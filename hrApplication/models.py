from django.db import models
from django.contrib.auth.models import User


class Employee(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone = models.IntegerField(null=True, default=None)
    title = models.CharField(max_length=128)
    department = models.CharField(max_length=128, null=True)
    hour_rate = models.FloatField(null=True)


class Attendance(models.Model):
    check_in = models.DateTimeField()
    check_out = models.DateTimeField(null=True)
    employee = models.ForeignKey(Employee, null=False, on_delete=models.CASCADE)


class Vacation(models.Model):
    vacation_date = models.DateTimeField(null=False)
    reason = models.CharField(max_length=350)
    employee = models.ForeignKey(Employee, null=False, on_delete=models.CASCADE)
