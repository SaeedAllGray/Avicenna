from django.contrib.auth.hashers import check_password, make_password
from django.core import serializers
from django.http import HttpResponse, JsonResponse
from django.shortcuts import get_list_or_404, get_object_or_404
from rest_framework.decorators import api_view
from rest_framework.response import Response

from .models import Appointment, CustomUser
from .serializers import AppointmentSerializer


def index(request):
    return HttpResponse("Hello, world. You're at the avicenna index.")


@api_view(['DELETE'])
def delete_user(request, user_id):
    user = get_object_or_404(CustomUser, id=user_id)
    user.delete()
    return Response(status=204)

@api_view(['POST'])
def create_user(request, username, user_password, email, first_name, last_name, is_doctor, is_patient):
    response = "You've created user #%s."
    return HttpResponse(response % user_id)


def update_user(request, user_id):
    return HttpResponse("You've updated user #%s." % user_id)


@api_view(['GET'])
def log_in_user(request, username, user_password):
    try:
        user = CustomUser.objects.get(username=username)
    except CustomUser.DoesNotExist:
        return Response(status=400)
    if not check_password(user_password, user.password):
        return Response(status=400)
    user_data = serializers.serialize('json', [user])
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