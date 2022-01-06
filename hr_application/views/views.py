from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.http import HttpResponseRedirect, HttpResponse
from django.contrib.auth.decorators import login_required
from hr_application.models import Employee, Attendance, Vacation
from django.http import JsonResponse
from datetime import datetime, timedelta
from django.db.models import Q
from hr_application.helpers.enum import attendance_type
from hr_application.helpers.helper import strfdelta, getgriddatapaginated, ajax_response


@login_required(login_url='/login')
def home(request):
    return render(request, 'web/home.html')


def login_form(request):
    return render(request, 'login.html')


def login_auth(request):
    name = request.POST['username_email']
    password = request.POST['user_pass']
    user = authenticate(request, username=name, password=password)
    if user:
        login(request, user)
        if not user.is_superuser:
            return redirect('hr_application:home_page')
        else:
            return HttpResponseRedirect('admin')
    return render(request, 'login.html', {"not_auth": True})


def log_out(request):
    logout(request)
    return redirect('hr_application:login')


def employee_form_post(request):
    try:
        user = request.user
        user.first_name = request.POST['first_name']
        user.last_name = request.POST['last_name']
        user.email = request.POST['email']
        emp = user.employee
        emp.phone = request.POST['phone_num']
        user.save()
        emp.save()
        full_name = "{0} {1}".format(user.first_name, user.last_name)
        return JsonResponse({'status': "SUCCESS", 'full_name': full_name}, status=200)
    except Exception as e:
        return JsonResponse({'status': "FAILED"}, status=500)


@login_required(login_url='/login')
def attendance(request):
    ctx = {}
    today = datetime.now().date()
    tomorrow = today + timedelta(1)

    att = Attendance.objects.filter(Q(check_in__gt=today)
                                    & Q(check_in__lt=tomorrow)
                                    & Q(employee=request.user.employee)).first()
    ctx['attendance'] = att
    if att:
        ctx['hours_num'] = strfdelta((att.check_out - att.check_in),
                                     "{hours}:{minutes}:{seconds}") if att.check_out else ''
        ctx['is_check_in'] = attendance_type.check_out.value
        ctx['is_complete_attendance'] = True if att.check_in and att.check_out else False
    else:
        ctx['is_check_in'] = attendance_type.check_in.value
    return render(request, 'web/attendance.html', ctx)


def attendance_post(request):
    try:
        is_check_in = request.POST['is_check_in']
        attendance_id = request.POST['attendance_id']
        attendance_obj = Attendance.objects.filter(id=attendance_id).first() if attendance_id else Attendance()
        if is_check_in == attendance_type.check_in.value:
            attendance_obj.check_in = datetime.now()
        else:
            attendance_obj.check_out = datetime.now()
        attendance_obj.employee = request.user.employee
        attendance_obj.save()
        return JsonResponse({'status': 'SUCCESS'}, status=200)
    except Exception as e:
        return JsonResponse({'status': "FAILED"}, status=500)

def attendance_grid_data(request):
    grid_columns = ('check_in', 'check_out')
    attendance_list = Attendance.objects.filter(employee=request.user.employee)
    sort_column = grid_columns[int(request.GET['order[0][column]'])]
    ctx = getgriddatapaginated(request, attendance_list, sort_column)
    json_data = []
    for item in ctx['data']:
        dict = {}
        dict['check_in'] = item.check_in.strftime("%Y-%m-%d %H:%M:%S")
        if item.check_out:
            dict['check_out'] = item.check_out.strftime("%Y-%m-%d %H:%M:%S")
            dict['working_hours'] = strfdelta((item.check_out - item.check_in), "{hours}:{minutes}")
        else:
            dict['check_out'] = ''
            dict['working_hours'] = ''
        json_data.append(dict)
    ctx['data'] = json_data
    return ajax_response(ctx)


@login_required(login_url='/login')
def vacation(request):
    ctx = {}
    count = Vacation.objects.filter(employee=request.user.employee).count()
    ctx['remaining_vacation_days'] = 15 - count
    return render(request, 'web/vacation.html', ctx)


def vacation_grid_data(request):
    grid_columns = ('vacation_date', 'reason')
    vacation_list = Vacation.objects.filter(employee=request.user.employee)
    sort_column = grid_columns[int(request.GET['order[0][column]'])]
    ctx = getgriddatapaginated(request, vacation_list, sort_column)

    json_data = []
    for item in ctx['data']:
        dict = {}
        dict['id'] = item.id
        dict['vacation_date'] = item.vacation_date.strftime("%Y-%m-%d")
        dict['reason'] = item.reason
        json_data.append(dict)
    ctx['data'] = json_data
    return ajax_response(ctx)


def vacation_form_save(request):
    try:
        count = Vacation.objects.filter(employee=request.user.employee).count()
        vacation_id = request.POST['Vacation_Id']
        vacation_date = request.POST['Vacation_Date']
        vacation_reason = request.POST['Vacation_Reason']

        if vacation_id != '':
            edit_similar_vacation = Vacation.objects.filter(Q(vacation_date=vacation_date)
                                                            & Q(employee=request.user.employee)) \
                .exclude(id=vacation_id).count()
            if edit_similar_vacation != 0:
                status = "Vacation already saved!"
            else:
                vacation = Vacation.objects.filter(id=vacation_id).first()
                status = 'SUCCESS'
        elif count < 15:
            similar_vacation = Vacation.objects.filter(
                Q(vacation_date=vacation_date) & Q(employee=request.user.employee)).count()
            if similar_vacation != 0:
                status = "Vacation already saved!"
            else:
                vacation = Vacation()
                count = count + 1
                status = 'SUCCESS'
        else:
            status = "You have reached your maximum number of vacations"

        if status == 'SUCCESS':
            vacation.vacation_date = vacation_date
            vacation.reason = vacation_reason
            vacation.employee = request.user.employee
            vacation.save()

        return JsonResponse({'status': status, "remaining_vacation_days": 15 - count}, status=200)

    except Exception as e:
        return JsonResponse({'status': "FAILED"}, status=500)


def vacation_delete(request):
    try:
        vacation_id = request.POST['vacation_id']
        Vacation.objects.filter(pk=vacation_id).delete()
        count = Vacation.objects.filter(employee=request.user.employee).count()
        return JsonResponse({'status': "SUCCESS", "remaining_vacation_days": 15 - count}, status=200)
    except Exception as e:
        return JsonResponse({'status': "FAILED"}, status=500)


@login_required(login_url='/login')
def salary(request):
    try:
        today = datetime.now()
        attendance_list = Attendance.objects.filter(check_in__year=today.year,
                                                    check_in__month=today.month,
                                                    employee=request.user.employee)
        hour_rate = request.user.employee.hour_rate
        total_working_hours = 0

        for att in attendance_list:
            if att.check_in and att.check_out:
                diff = att.check_out - att.check_in
                days, seconds = diff.days, diff.seconds
                hours = days * 24 + round(seconds / 3600, 2)
                total_working_hours = total_working_hours + hours
        ctx = {}
        ctx['total_working_hours'] = total_working_hours
        ctx['total_salary'] = round(total_working_hours * hour_rate, 2)
        return render(request, 'web/salary.html', ctx)
    except Exception as e:
        return JsonResponse({'status': "FAILED"}, status=500)
