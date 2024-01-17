from rest_framework import serializers

from .models import CustomUser, Doctor, Patient, Review, TimeSlot


class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = ["id", "rating", "comment", "patient_id", "doctor_id", "date_left"]


class TimeSlotSerializer(serializers.ModelSerializer):
    class Meta:
        model = TimeSlot
        fields = [
            "id",
            "day",
            "beginning",
            "end",
            "doctor_id",
            "patient_id",
            "is_confirmed",
            "is_booked",
        ]


class CustomUserSerializer(serializers.ModelSerializer):
    date_joined = serializers.DateTimeField(read_only=True)
    last_login = serializers.DateTimeField(read_only=True)
    patient_id = serializers.PrimaryKeyRelatedField(
        allow_null=True, queryset=Patient.objects.all(), source="patient"
    )
    doctor_id = serializers.PrimaryKeyRelatedField(
        allow_null=True, queryset=Doctor.objects.all(), source="doctor"
    )

    class Meta:
        model = CustomUser
        fields = [
            "id",
            "first_name",
            "last_name",
            "email",
            "patient_id",
            "doctor_id",
            "username",
            "password",
            "date_joined",
            "last_login",
        ]


class DoctorSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()
    average_rating = serializers.SerializerMethodField()

    class Meta:
        model = Doctor
        fields = [
            "user",
            "phone_number",
            "specialization",
            "address",
            "average_rating",
        ]

    def get_average_rating(self, obj) -> float:
        return obj.get_average_rating()


class PatientSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()

    class Meta:
        model = Patient
        fields = ["basic_user_info", "ssn", "date_born"]
