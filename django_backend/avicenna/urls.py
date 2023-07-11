from django.urls import path

from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("api/delete-user/<int:user_id>/", views.delete_user, name="delete_user"),
    path("<int:user_id>/create/", views.create_user, name="create_user"),
    path("<int:user_id>/update/", views.update_user, name="update_user"),
    path("<int:user_id>/register/", views.register_user, name="register_user"),
    path("api/login/<str:username>/<user_password>", views.log_in_user, name="log_in_user"),
    path("api/get-appointments/<int:user_id>/", views.get_appointments_by_user_id, name="get_appointments_by_user_id"),
    path('api/delete-appointment/<int:appointment_id>/', views.delete_appointment, name='delete_appointment'),
    path('api/create-appointment/<int:doctor_id>/<int:patient_id>/<str:appointment_timestamp>/', views.create_appointment, name='create_appointment')
]