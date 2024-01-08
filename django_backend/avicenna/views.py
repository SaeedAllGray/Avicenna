from django.db.models import Q
from rest_framework import viewsets
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.response import Response

from .models import CustomUser, Doctor, Patient, Review, TimeSlot
from .serializers import (
    CustomUserSerializer,
    DoctorSerializer,
    PatientSerializer,
    ReviewSerializer,
    TimeSlotSerializer,
)


class CustomAuthToken(ObtainAuthToken):
    """Modified ObtainAuthToken returning user_id in addition."""

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(
            data=request.data, context={"request": request}
        )
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data["user"]
        token, created = Token.objects.get_or_create(user=user)
        return Response({"token": token.key, "user_id": user.pk})


class ReviewViewSet(viewsets.ModelViewSet):
    serializer_class = ReviewSerializer

    def get_queryset(self):
        """
        Optionally restricts the returned reviews to a given user,
        by filtering against a `user_id` query parameter in the URL.
        """
        queryset = Review.objects.all()
        user_id = self.request.query_params.get("user_id", None)
        if user_id is not None:
            queryset = queryset.filter(Q(patient__pk=user_id) | Q(doctor__pk=user_id))
        return queryset


class TimeSlotViewSet(viewsets.ModelViewSet):
    serializer_class = TimeSlotSerializer

    def get_queryset(self):
        """
        Optionally restricts the returned reviews to a given user,
        by filtering against a `user_id` query parameter in the URL.
        """
        queryset = TimeSlot.objects.all()
        user_id = self.request.query_params.get("user_id", None)
        if user_id is not None:
            queryset = queryset.filter(Q(patient__pk=user_id) | Q(doctor__pk=user_id))
        return queryset


class CustomUserViewSet(viewsets.ModelViewSet):
    """The base User object's fields.

    Specific Doctor or Patient objects should be preferred.
    """

    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer


class DoctorViewSet(viewsets.ModelViewSet):
    queryset = Doctor.objects.all()
    serializer_class = DoctorSerializer


class PatientViewSet(viewsets.ModelViewSet):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer
