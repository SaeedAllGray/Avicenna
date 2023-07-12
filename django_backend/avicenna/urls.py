from django.urls import path

from . import views

urlpatterns = [
    path(
        "",
        views.index,
        name="index"),
    path(
        "api/delete-user/<int:user_id>/",
        views.delete_user,
        name="delete_user"),
    path(
        "api/create-user/doctor/<str:username>/<str:user_password>/<str:first_name>/<str:last_name>/<str:email>/<str:phone_number>/<str:specialization>/<str:address>/",
        views.create_user,
        kwargs=dict(
            user_type="doctor"),
        name="create_user_doctor"),
    path(
        "api/create-user/patient/<str:username>/<str:user_password>/<str:first_name>/<str:last_name>/<str:email>/<ssn>/",
        views.create_user,
        kwargs=dict(
            user_type="patient"),
        name="create_user_patient"),
    path(
        "api/login/<str:username>/<user_password>",
        views.log_in_user,
        name="log_in_user"),
    path(
        "api/get-appointments/doctor/<int:user_id>/",
        views.get_appointments_by_user_id,
        kwargs=dict(
            user_type="doctor"),
        name="get_appointments_by_user_id_doctor"),
    path(
        "api/get-appointments/patient/<int:user_id>/",
        views.get_appointments_by_user_id,
        kwargs=dict(
            user_type="patient"),
        name="get_appointments_by_user_id_patient"),
    path(
        'api/delete-appointment/<int:appointment_id>/',
        views.delete_appointment,
        name='delete_appointment'),
    path(
        'api/create-appointment/<int:doctor_id>/<int:patient_id>/<str:appointment_timestamp>/',
        views.create_appointment,
        name='create_appointment'),
    path(
        'api/get-all-doctors/',
        views.get_all_doctors,
        name='get_all_doctors')]
