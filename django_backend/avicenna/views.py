from django.core import serializers
from django.http import HttpResponse, JsonResponse
from django.shortcuts import get_list_or_404, get_object_or_404, render
from rest_framework.decorators import api_view
from rest_framework.response import Response

from .models import Appointment, CustomUser


def index(request):
    return HttpResponse("Hello, world. You're at the avicenna index.")


@api_view(['DELETE'])
def delete_user(request, user_id):
    user = get_object_or_404(CustomUser, id=user_id)
    user.delete()
    return Response(status=204)

def create_user(request, user_id):
    response = "You've created user #%s."
    return HttpResponse(response % user_id)


def update_user(request, user_id):
    return HttpResponse("You've updated user #%s." % user_id)


def register_user(request, user_id):
    return HttpResponse("You've registered user #%s." % user_id)


def log_in_user(request, user_id):
    return HttpResponse("You've logged in as user #%s." % user_id)


@api_view(['GET'])
def get_appointments_by_user_id(request, user_id):
    appointments = get_list_or_404(
        Appointment.objects.order_by('appointment_timestamp'),
        doctor__user__id__exact=user_id)  # TODO: make it support both patients and doctors
    appointment_data = serializers.serialize('json', appointments)
    return JsonResponse(appointment_data, safe=False)

@api_view(['DELETE'])
def delete_appointment(request, appointment_id):
    appointment = get_object_or_404(Appointment, id=appointment_id)
    appointment.delete()
    return Response(status=204)
