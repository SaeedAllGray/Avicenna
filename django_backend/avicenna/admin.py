from django.contrib import admin

from .models import Doctor, Patient, Appointment

admin.site.register((Doctor, Patient, Appointment))