from django.db.models import Q
from rest_framework import viewsets
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.generics import mixins
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from .models import CustomUser, Doctor, Patient, Review, TimeSlot
from .serializers import (
    CustomUserSerializer,
    DoctorCreateSerializer,
    DoctorSerializer,
    PatientCreateSerializer,
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

        user_data = {}
        if hasattr(user, "patient"):
            user_serializer = PatientSerializer(
                user.patient, context={"request": request}
            )
        elif hasattr(user, "doctor"):
            user_serializer = DoctorSerializer(
                user.doctor, context={"request": request}
            )
        else:
            raise ValueError("Unknown user type.")
        user_data = user_serializer.data
        return Response({"token": token.key, **user_data})


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


class CustomUserViewSet(
    mixins.RetrieveModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    mixins.ListModelMixin,
    viewsets.GenericViewSet,
):
    """The base User object's fields.

    Creating is not allowed due to it's being an
    unauthenticated action within this code's logic.
    """

    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer


class CreateCustomUserViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """The base User object's fields.

    Creating is an action requiring no authentication
    within this code's logic.
    """

    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer
    authentication_classes = []
    permission_classes = [AllowAny]


class DoctorViewSet(
    mixins.RetrieveModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    mixins.ListModelMixin,
    viewsets.GenericViewSet,
):
    """Doctor endpoint supporting all operations except creating.

    Creating is not allowed due to it's being an
    unauthenticated action within this code's logic.
    """

    queryset = Doctor.objects.all()
    serializer_class = DoctorSerializer


class CreateDoctorViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """Doctor endpoint supporting only creating.

    Creating is an action requiring no authentication
    within this code's logic.
    """

    queryset = Doctor.objects.all()
    serializer_class = DoctorCreateSerializer
    authentication_classes = []
    permission_classes = [AllowAny]


class PatientViewSet(
    mixins.RetrieveModelMixin,
    mixins.UpdateModelMixin,
    mixins.DestroyModelMixin,
    mixins.ListModelMixin,
    viewsets.GenericViewSet,
):
    """Patient endpoint supporting all operations except creating.

    Creating is not allowed due to it's being an
    unauthenticated action within this code's logic.
    """

    queryset = Patient.objects.all()
    serializer_class = PatientSerializer


class CreatePatientViewSet(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """Patient endpoint supporting only creating.

    Creating is an action requiring no authentication
    within this code's logic.
    """

    queryset = Patient.objects.all()
    serializer_class = PatientCreateSerializer
    authentication_classes = []
    permission_classes = [AllowAny]
