import json
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.http import HttpResponseRedirect, HttpResponse
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from hrApplication.models import Employee, Attendance, Vacation
from django.http import JsonResponse
from datetime import datetime, timedelta
from django.db.models import Q
from hrApplication.helpers.enum import attendance_type
from hrApplication.helpers.helper import strfdelta, getgriddatapaginated, ajax_response
from django.core.serializers import serialize
from django.core import serializers


@login_required(login_url='/login')
def home(request):
    ctx = {}
    user = request.user
    ctx["employee"] = Employee.objects.get(user=request.user)
    ctx["first_name"] = user.first_name
    ctx["last_name"] = user.last_name
    ctx['user'] = user
    return render(request, 'web/home.html', ctx)


def login_form(request):
    return render(request, 'login.html')


def login_auth(request):
    name = request.POST['userNameEmail']
    password = request.POST['userPass']
    user = authenticate(request, username=name, password=password)
    if user:
        login(request, user)
        if not user.is_superuser:
            return redirect('hrApplication:home_page')
        else:
            return HttpResponseRedirect('admin')
    return render(request, 'login.html', {"not_auth": True})


def log_out(request):
    logout(request)
    return redirect('hrApplication:login')


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
        return JsonResponse({'status': "SUCCESS"}, status=200)
    except Exception as e:
        return JsonResponse({'status': "FAILED"}, status=500)


@login_required(login_url='/login')
def attendance(request):
    try:
        ctx = {}
        user = request.user
        ctx["first_name"] = user.first_name
        ctx["last_name"] = user.last_name

        today = datetime.now().date()
        tomorrow = today + timedelta(1)

        att = Attendance.objects.get(Q(checkIn__gt=today)
                                     & Q(checkIn__lt=tomorrow)
                                     & Q(employee=user.employee))

        ctx['hours_num'] = strfdelta((att.checkOut - att.checkIn),
                                     "{hours}:{minutes}:{seconds}") if att.checkOut is not None else ''
    except Attendance.DoesNotExist:
        att = None
    ctx['attendance'] = att
    if att:
        ctx['is_check_in'] = attendance_type.check_out.value
        ctx['is_complete_attendance'] = True if att.checkIn != None and att.checkOut != None else False
    else:
        ctx['is_check_in'] = attendance_type.check_in.value
    return render(request, 'web/attendance.html', ctx)


def attendance_post(request):
    is_check_in = request.POST['is_check_in']
    attendanceid = request.POST['attendance_id']

    attendance_obj = Attendance.objects.get(id=attendanceid) if attendanceid else Attendance()

    if is_check_in == attendance_type.check_in.value:
        attendance_obj.checkIn = datetime.now()
    elif is_check_in == attendance_type.check_out.value:
        attendance_obj.checkOut = datetime.now()
    attendance_obj.employee = request.user.employee
    attendance_obj.save()
    return JsonResponse({'status': 'SUCCESS'}, status=200)


def attendance_grid_data(request):
    grid_columns = ('checkIn', 'checkOut')
    data = Attendance.objects.filter(employee=request.user.employee)

    name = grid_columns[int(request.GET['order[0][column]'])]

    ctx = getgriddatapaginated(request, data, name)

    json_data = []
    for item in ctx['data']:
        dict = {}
        dict['checkIn'] = item.checkIn.strftime("%Y-%m-%d %H:%M:%S")
        if item.checkOut:
            dict['checkOut'] = item.checkOut.strftime("%Y-%m-%d %H:%M:%S")
            dict['working_hours'] = strfdelta((item.checkOut - item.checkIn), "{hours}:{minutes}")
        else:
            dict['checkOut'] = ''
            dict['working_hours'] = ''
        json_data.append(dict)
    ctx['data'] = json_data

    return ajax_response(ctx)


@login_required(login_url='/login')
def vacation(request):
    ctx = {}
    count = Vacation.objects.filter(employee=request.user.employee).count()
    user = request.user
    ctx["employee"] = Employee.objects.get(user=request.user)
    ctx["first_name"] = user.first_name
    ctx["last_name"] = user.last_name
    ctx['remaining_vacation_days'] = 15 - count

    return render(request, 'web/vacation.html', ctx)


def vacation_grid_data(request):
    grid_columns = ('vacationDate', 'reason')
    data = Vacation.objects.filter(employee=request.user.employee)

    name = grid_columns[int(request.GET['order[0][column]'])]

    ctx = getgriddatapaginated(request, data, name)

    json_data = []
    for item in ctx['data']:
        dict = {}

        dict['id'] = item.id
        dict['vacationDate'] = item.vacationDate.strftime("%Y-%m-%d")
        dict['reason'] = item.reason
        dict['edit'] = ''
        dict['delete'] = ''
        json_data.append(dict)
    ctx['data'] = json_data
    return ajax_response(ctx)


def vacation_form_save(request):
    try:
        count = Vacation.objects.filter(employee=request.user.employee).count()

        vacationid = request.POST['Vacation_Id']
        vacation_date = request.POST['Vacation_Date']
        vacation_reason = request.POST['Vacation_Reason']

        similar_vacation = Vacation.objects.filter(vacationDate=vacation_date).count()

        if vacationid:
            edit_similar_vacation = Vacation.objects.filter(vacationDate=vacation_date).exclude(id=vacationid).count()

            if edit_similar_vacation != 0:
                return JsonResponse({'status': "Vacation already saved!"}, status=200)
            vacation = Vacation.objects.get(id=vacationid)
        elif count < 15:
            if similar_vacation != 0:
                return JsonResponse({'status': "Vacation already saved!"}, status=200)
            vacation = Vacation()
            count = count + 1
        else:
            return JsonResponse({'status': "You have reached your maximum number of vacations"}, status=200)

        vacation.vacationDate = vacation_date
        vacation.reason = vacation_reason
        vacation.employee = request.user.employee
        vacation.save()
        return JsonResponse({'status': "SUCCESS", "remaining_vacation_days": 15 - count}, status=200)

    except Exception as e:
        return JsonResponse({'status': "FAILED"}, status=500)


def vacation_delete(request):
    try:
        vacation_id = request.POST['vacationId']
        Vacation.objects.get(pk=vacation_id).delete()
        count = Vacation.objects.filter(employee=request.user.employee).count()
        return JsonResponse({'status': "SUCCESS", "remaining_vacation_days": 15 - count}, status=200)
    except Exception as e:
        return JsonResponse({'status': "FAILED"}, status=500)
