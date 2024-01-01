from rest_framework import serializers

from .models import CustomUser, Doctor, Patient, Review, TimeSlot


class ReviewSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Review
        fields = ["url", "rating", "comment", "patient", "doctor"]


class TimeSlotSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = TimeSlot
        fields = [
            "url",
            "day",
            "beginning",
            "end",
            "doctor",
            "patient",
            "is_confirmed",
            "is_booked",
        ]


class CustomUserSerializer(serializers.HyperlinkedModelSerializer):
    patient = serializers.HyperlinkedIdentityField("patient-detail")
    doctor = serializers.HyperlinkedIdentityField("doctor-detail")

    class Meta:
        model = CustomUser
        fields = [
            "url",
            "first_name",
            "last_name",
            "email",
            "patient",
            "doctor",
            "username",
            "password",
            "date_joined",
            "last_login",
        ]


class DoctorSerializer(serializers.HyperlinkedModelSerializer):
    user = CustomUserSerializer()
    average_rating = serializers.SerializerMethodField()

    class Meta:
        model = Doctor
        fields = [
            "url",
            "user",
            "phone_number",
            "specialization",
            "address",
            "average_rating",
        ]

    def get_average_rating(self, obj) -> float:
        return obj.get_average_rating()


class PatientSerializer(serializers.HyperlinkedModelSerializer):
    user = CustomUserSerializer()

    class Meta:
        model = Patient
        fields = ["url", "user", "ssn", "date_born"]
