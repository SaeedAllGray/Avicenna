from rest_framework import serializers

from .models import CustomUser, Doctor, Patient, Review, TimeSlot


class ReviewSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Review
        fields = ["url", "id", "rating", "comment", "patient", "doctor", "date_left"]


class TimeSlotSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = TimeSlot
        fields = [
            "url",
            "id",
            "day",
            "beginning",
            "end",
            "doctor",
            "patient",
            "is_confirmed",
            "is_booked",
        ]


class CustomUserSerializer(serializers.HyperlinkedModelSerializer):
    date_joined = serializers.DateTimeField(read_only=True)
    last_login = serializers.DateTimeField(read_only=True)

    class Meta:
        model = CustomUser
        fields = [
            "url",
            "id",
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
    basic_user_info = CustomUserSerializer(source="user")
    average_rating = serializers.SerializerMethodField()

    class Meta:
        model = Doctor
        fields = [
            "basic_user_info",
            "phone_number",
            "specialization",
            "address",
            "average_rating",
        ]

    def get_average_rating(self, obj) -> float:
        return obj.get_average_rating()


class PatientSerializer(serializers.HyperlinkedModelSerializer):
    basic_user_info = CustomUserSerializer(source="user")

    class Meta:
        model = Patient
        fields = ["basic_user_info", "ssn", "date_born"]
