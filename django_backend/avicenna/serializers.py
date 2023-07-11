from rest_framework import serializers

from .models import Appointment, CustomUser


class AppointmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Appointment
        fields = ['doctor', 'patient', 'appointment_timestamp']

    
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['doctor', 'patient', 'appointment_timestamp']
