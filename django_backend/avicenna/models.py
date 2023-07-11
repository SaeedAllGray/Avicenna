import uuid

from django.conf import settings
from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils import timezone


# refer to https://docs.djangoproject.com/en/4.2/ref/contrib/auth/#fields
# to see the default fields
class CustomUser(AbstractUser):
    email = models.CharField(max_length=50)
    username = models.CharField(
        unique=True,
        max_length=100,
        default=str(
            uuid.uuid4()))
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    is_doctor = models.BooleanField(default=False)
    is_patient = models.BooleanField(default=False)

    def __str__(self):
        return self.get_full_name()


class Doctor(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        primary_key=True,
        on_delete=models.CASCADE)
    phone_number = models.CharField(max_length=30)
    specialization = models.CharField(max_length=100)
    address = models.CharField(max_length=100)

    def __str__(self):
        return str(self.user)

# django.contrib.auth.get_user_model()


class Patient(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        primary_key=True,
        on_delete=models.CASCADE)
    ssn = models.CharField(
        'Social Security number',
        max_length=9)  # example: 790714615
    
    def __str__(self):
        return str(self.user)


class Appointment(models.Model):
    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    created_timestamp = models.DateTimeField(auto_now_add=True)
    appointment_timestamp = models.DateTimeField('appointemnt\'s date')

    def days_remaining_from_now(self):
        self.remaining_time = timezone.now() - self.appointment_timestamp
        return self.remaining_time.days
    
#    def get_all_appointments_by_user_id(self, user_id):
#        pass

    def __str__(self):
        return 'Appointment on {:%B %d, %Y} for Dr. {} and patient {}'.format(
            self.appointment_timestamp, str(self.doctor), str(self.patient))
