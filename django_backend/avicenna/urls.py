from django.urls import include, path
from rest_framework.routers import DefaultRouter

from avicenna import views
from avicenna.views import CustomAuthToken

router = DefaultRouter()
router.register(r"reviews", views.ReviewViewSet, basename="review")
router.register(r"time-slots", views.TimeSlotViewSet, basename="timeslot")
router.register(r"custom-users", views.CustomUserViewSet)
router.register(
    r"create-custom-users", views.CreateCustomUserViewSet, basename="create_custom_user"
)
router.register(r"doctors", views.DoctorViewSet)
router.register(r"create-doctors", views.CreateDoctorViewSet, basename="create_doctor")
router.register(r"patients", views.PatientViewSet)
router.register(
    r"create-patients", views.CreatePatientViewSet, basename="create_patient"
)

urlpatterns = [
    path("", include(router.urls)),
    path("api-auth/", include("rest_framework.urls")),
    path("api-token-auth/", CustomAuthToken.as_view()),
]
