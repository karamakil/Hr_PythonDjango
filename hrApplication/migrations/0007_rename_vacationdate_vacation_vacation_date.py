# Generated by Django 4.0 on 2022-01-03 23:54

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('hrApplication', '0006_rename_checkin_attendance_check_in_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='vacation',
            old_name='vacationDate',
            new_name='vacation_date',
        ),
    ]