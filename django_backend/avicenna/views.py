from django.contrib.auth.hashers import check_password, make_password
from django.core import serializers
from django.http import HttpResponse
from django.shortcuts import get_list_or_404, get_object_or_404
from rest_framework.decorators import api_view
from rest_framework.response import Response

from .models import Appointment, CustomUser, Doctor, Patient
from .serializers import AppointmentSerializer, DoctorSerializer, PatientSerializer


def index(request):
    return HttpResponse("Hello, world. You're at the avicenna index.")


@api_view(['DELETE'])
def delete_user(request, user_id):
    user = get_object_or_404(CustomUser, id=user_id)
    user.delete()
    return Response(status=204)


@api_view(['POST'])
def create_user(
        request,
        username,
        user_password,
        email,
        first_name,
        last_name,
        user_type,
        phone_number=None,
        specialization=None,
        address=None,
        ssn=None):
    try:
        CustomUser.objects.get(username=username)
    except CustomUser.DoesNotExist:
        pass
    else:
        return Response('Username is already is use', status=400)
    user_password = make_password(user_password)

    if user_type == 'doctor':
        doctor_serializer = DoctorSerializer(data={
            'user': {
                'username': username,
                'password': user_password,
                'email': email,
                'first_name': first_name,
                'last_name': last_name,
                'is_doctor': True,
                'is_patient': False
            },
            'phone_number': phone_number,
            'specialization': specialization,
            'address': address
        })
        if doctor_serializer.is_valid():
            doctor_serializer.save()
            return Response(doctor_serializer.data, status=201)
        CustomUser.objects.filter(username=username).delete()
        return Response(doctor_serializer.errors, status=400)
    elif user_type == 'patient':
        patient_serializer = PatientSerializer(data={
            'user': {
                'username': username,
                'password': user_password,
                'email': email,
                'first_name': first_name,
                'last_name': last_name,
                'is_doctor': False,
                'is_patient': True
            },
            'ssn': ssn
        })
        if patient_serializer.is_valid():
            patient_serializer.save()
            return Response(patient_serializer.data, status=201)
        CustomUser.objects.filter(username=username).delete()
        return Response(patient_serializer.errors, status=400)
    else:
        return Response('Bruh', status=400)


@api_view(['GET'])
def log_in_user(request, username, user_password):
    try:
        user = CustomUser.objects.get(username=username)
    except CustomUser.DoesNotExist:
        return Response(status=400)
    if not check_password(user_password, user.password):
        return Response(status=400)
    if user.is_doctor:
        doctor = Doctor.objects.get(user_id=user.id)
        user_data = serializers.serialize('json', [user, doctor])
    elif user.is_patient:
        patient = Patient.objects.get(user_id=user.id)
        user_data = serializers.serialize('json', [user, patient])
    return HttpResponse(user_data)


@api_view(['GET'])
def get_appointments_by_user_id(request, user_id, user_type):
    if user_type == 'doctor':
        appointments = get_list_or_404(
            Appointment.objects.order_by('appointment_timestamp'),
            doctor__user__id__exact=user_id)
    elif user_type == 'patient':
        appointments = get_list_or_404(
            Appointment.objects.order_by('appointment_timestamp'),
            patient__user__id__exact=user_id)
    else:
        return Response(status=400)
    appointment_data = serializers.serialize('json', appointments)
    return HttpResponse(appointment_data)


@api_view(['DELETE'])
def delete_appointment(request, appointment_id):
    appointment = get_object_or_404(Appointment, id=appointment_id)
    appointment.delete()
    return Response(status=204)


@api_view(['POST'])
def create_appointment(request, doctor_id, patient_id, appointment_timestamp):
    serializer = AppointmentSerializer(data={
        'doctor': doctor_id,
        'patient': patient_id,
        'appointment_timestamp': appointment_timestamp
    })
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=201)
    return Response(serializer.errors, status=400)


@api_view(['GET'])
def get_all_doctors(request):
    users = CustomUser.objects.filter(is_doctor=True)
    serialized_data = []

    for user in users:
        doctor = Doctor.objects.get(user=user)
        serialized_data.append(serializers.serialize('json', [user, doctor], fields=(
            'pk', 'email', 'first_name', 'last_name', 'phone_number', 'specialization', 'address')))

    result = ','.join(serialized_data)
    return HttpResponse(f'[{result}]')


@api_view(['GET'])
def get_doctor_by_id(request, doctor_id):
    user = get_object_or_404(CustomUser, pk=doctor_id)
    doctor = get_object_or_404(Doctor, pk=doctor_id)
    serialized_data = serializers.serialize('json', [user, doctor], fields=('pk', 'email', 'first_name', 'last_name', 'phone_number', 'specialization', 'address'))

    return HttpResponse(serialized_data)
