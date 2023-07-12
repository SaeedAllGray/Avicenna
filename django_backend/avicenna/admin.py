from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

from .models import Appointment, CustomUser, Doctor, Patient


class DoctorInline(admin.StackedInline):
    model = Doctor
    can_delete = False


class PatientInline(admin.StackedInline):
    model = Patient
    can_delete = False


class UserAdmin(BaseUserAdmin):
    inlines = [DoctorInline, PatientInline]

    list_display = (
        "username",
        "email",
        "first_name",
        "last_name",
        "is_doctor",
        "is_patient",
        "is_active")

    fieldsets = (
        *BaseUserAdmin.fieldsets,  # original form fieldsets, expanded
        (                      # new fieldset added on to the bottom
            'Custom Field Heading',
            # group heading of your choice; set to None for a blank space
            # instead of a header
            {
                'fields': (
                    'is_doctor',
                    'is_patient'
                ),
            },
        ),
    )


admin.site.register(CustomUser, UserAdmin)
admin.site.register(Appointment)
