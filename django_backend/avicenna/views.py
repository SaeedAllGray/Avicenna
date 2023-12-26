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
    # TODO: add a query parameter to only get review for a specific doctor or patient
    queryset = Review.objects.all()
    serializer_class = ReviewSerializer


class TimeSlotViewSet(viewsets.ModelViewSet):
    # TODO: same as above
    queryset = TimeSlot.objects.all()
    serializer_class = TimeSlotSerializer


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
