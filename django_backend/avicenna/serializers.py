from rest_framework import serializers

from .models import Appointment, CustomUser, Patient, Doctor


class AppointmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Appointment
        fields = ['doctor', 'patient', 'appointment_timestamp']

    
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['email', 'username', 'first_name', 'last_name', 'is_doctor', 'is_patient']

class DoctorSerializer(serializers.ModelSerializer):
    user = UserSerializer()
    class Meta:
        model = Doctor
        fields = ['user', 'phone_number', 'specialization', 'address']

class PatientSerializer(serializers.ModelSerializer):
    user = UserSerializer()
    class Meta:
        model = Patient
        fields = ['user', 'ssn']
