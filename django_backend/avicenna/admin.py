from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

from .models import CustomUser, Doctor, Patient, Review, TimeSlot


class CommonInfoMixin:
    """Common fields for the inline models."""

    extra = 0
    max_num = 1
    can_delete = False


class DoctorInline(admin.TabularInline, CommonInfoMixin):
    model = Doctor


class PatientInline(admin.TabularInline, CommonInfoMixin):
    model = Patient


class UserAdmin(BaseUserAdmin):
    inlines = [DoctorInline, PatientInline]

    fieldsets = [
        (
            "Personal information",
            {"fields": [("first_name", "last_name"), "email"]},
        ),
        (
            "Authentication options",
            {"fields": ["username", "password"]},
        ),
        (
            "Technical options",
            {
                "classes": ["collapse"],
                "fields": [
                    ("last_login", "date_joined"),
                    ("is_superuser", "is_active", "is_staff"),
                    "user_permissions",
                    "groups",
                ],
            },
        ),
    ]


admin.site.register(CustomUser, UserAdmin)
admin.site.register(TimeSlot)
admin.site.register(Review)
