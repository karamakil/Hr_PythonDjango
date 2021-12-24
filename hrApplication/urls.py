from django.urls import path
from hrApplication.views import views


app_name = 'hrApplication'
urlpatterns = [
    path('', views.home, name='home_page'),
    path('login', views.login_form, name='login'),
    path('login_auth', views.login_auth, name='login_auth'),
    path('logout', views.log_out, name='logout'),

    path('employee_form_post', views.employee_form_post, name='employee_form_post'),

    path('attendance', views.attendance, name='attendance'),
    path('attendance_post', views.attendance_post, name='attendance_post'),
    path('attendance_grid_Data', views.attendance_grid_data, name='attendance_grid_Data'),

    path('vacation', views.vacation, name='vacation'),
    path('vacation_grid_Data', views.vacation_grid_data, name='vacation_grid_Data'),
    path('vacation_form_save', views.vacation_form_save, name='vacation_form_save'),
    path('vacation_delete', views.vacation_delete, name='vacation_delete'),
]
