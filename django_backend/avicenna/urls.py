from django.urls import path

from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("<int:user_id>/delete/", views.delete_user, name="delete_user"),
    path("<int:user_id>/create/", views.create_user, name="create_user"),
    path("<int:user_id>/update/", views.update_user, name="update_user"),
    path("<int:user_id>/register/", views.register_user, name="register_user"),
    path("<int:user_id>/login/", views.log_in_user, name="log_in_user"),
    path("api/<int:user_id>/appointments/", views.get_appointments_by_user_id, name="get_appointments_by_user_id"),
    path('api/delete-appointment/<int:appointment_id>/', views.delete_appointment, name='delete_appointment')
]