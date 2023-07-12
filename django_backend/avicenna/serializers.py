from rest_framework import serializers

from .models import Appointment, CustomUser, Doctor, Patient


class AppointmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Appointment
        fields = ['doctor', 'patient', 'appointment_timestamp']


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = [
            'email',
            'username',
            'password',
            'first_name',
            'last_name',
            'is_doctor',
            'is_patient']


class DoctorSerializer(serializers.ModelSerializer):
    user = UserSerializer()

    class Meta:
        model = Doctor
        fields = ['user', 'phone_number', 'specialization', 'address']

    def create(self, validated_data):
        user_data = validated_data.pop('user')
        user = CustomUser.objects.create(**user_data)
        doctor = Doctor.objects.create(user=user, **validated_data)
        return doctor


class PatientSerializer(serializers.ModelSerializer):
    user = UserSerializer()

    class Meta:
        model = Patient
        fields = ['user', 'ssn']

    def create(self, validated_data):
        user_data = validated_data.pop('user')
        user = CustomUser.objects.create(**user_data)
        patient = Patient.objects.create(user=user, **validated_data)
        return patient
