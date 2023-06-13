from django.db import models
from django.utils import timezone


class Doctor(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()
    phone_number = models.CharField(max_length=30)
    specialization = models.CharField(max_length=100)
    address = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Patient(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()

    def __str__(self):
        return self.name


class Appointment(models.Model):
    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    created_timestamp = models.DateTimeField(auto_now_add=True)
    appointment_timestamp = models.DateTimeField('appointemnt\'s date')

    def days_remaining_from_now(self):
        self.remaining_time = timezone.now() - self.appointment_timestamp
        return self.remaining_time.days
