from django.db import models
from django.contrib.auth.models import User


class Employee(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone = models.IntegerField(null=True, default=None)
    title = models.CharField(max_length=128)
    department = models.CharField(max_length=128, null=True)


class Attendance(models.Model):
    checkIn = models.DateTimeField()
    checkOut = models.DateTimeField(null=True)
    employee = models.ForeignKey(Employee, null=False, on_delete=models.CASCADE)


class Vacation(models.Model):
    vacationDate = models.DateTimeField(null=False)
    reason = models.CharField(max_length=350)
    employee = models.ForeignKey(Employee, null=False, on_delete=models.CASCADE)
