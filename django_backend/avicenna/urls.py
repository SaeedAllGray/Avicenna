from django.urls import include, path
from rest_framework.routers import DefaultRouter

from avicenna import views
from avicenna.views import CustomAuthToken

router = DefaultRouter()
router.register(r"reviews", views.ReviewViewSet)
router.register(r"time-slots", views.TimeSlotViewSet)
router.register(r"custom-users", views.CustomUserViewSet)
router.register(r"doctors", views.DoctorViewSet)
router.register(r"patients", views.PatientViewSet)

urlpatterns = [
    path("", include(router.urls)),
    path("api-auth/", include("rest_framework.urls")),
    path("api-token-auth/", CustomAuthToken.as_view()),
]
