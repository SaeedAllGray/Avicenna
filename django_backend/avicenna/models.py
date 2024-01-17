"""Main models."""

from django.conf import settings
from django.contrib.auth.models import AbstractUser
from django.core.validators import MaxValueValidator, RegexValidator
from django.db import models


class CustomUser(AbstractUser):
    """Common user fields.

    Subclasses AbstractUser.
    """

    first_name = models.CharField("first name", max_length=150)
    last_name = models.CharField("last name", max_length=150)
    email = models.EmailField("email address", unique=True)

    def __str__(self) -> str:
        return self.get_full_name()


class Doctor(models.Model):
    """Fields pertaining to the doctor.

    Extends CustomUser by means of OneToOne.
    """

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, primary_key=True, on_delete=models.CASCADE
    )
    phone_number = models.CharField(
        max_length=15,
        unique=True,
        help_text="Kindly use only numeric characters.",
        validators=[
            RegexValidator(
                regex=r"^\d+$",
                message="Enter a numeric only number",
                code="invalid_phone_number",
            ),
        ],
    )
    address = models.CharField(max_length=150)

    SPECIALIZATION_CHOICES = [
        ("cardiology", "Cardiology"),
        ("dermatology", "Dermatology"),
        ("endocrinology", "Endocrinology"),
        ("gastroenterology", "Gastroenterology"),
        ("neurology", "Neurology"),
        ("oncology", "Oncology"),
        ("orthopedics", "Orthopedics"),
        ("pediatrics", "Pediatrics"),
        ("psychiatry", "Psychiatry"),
        ("urology", "Urology"),
        (
            "Internal Medicine",
            [
                ("nephrology", "Nephrology"),
                ("pulmonology", "Pulmonology"),
                ("rheumatology", "Rheumatology"),
            ],
        ),
        (
            "Surgery",
            [
                ("general surgery", "General Surgery"),
                ("orthopedic surgery", "Orthopedic Surgery"),
                ("neurosurgery", "Neurosurgery"),
            ],
        ),
        (
            "Obstetrics and Gynecology",
            [
                ("obstetrics", "Obstetrics"),
                ("gynecology", "Gynecology"),
            ],
        ),
        ("ophthalmology", "Ophthalmology"),
        ("otolaryngology", "Otolaryngology"),
    ]
    specialization = models.CharField(max_length=50, choices=SPECIALIZATION_CHOICES)

    def get_average_rating(self) -> float:
        """Retrieves the average rating received by the doctor.

        Returns:
            float: The average rating limited to floats from 0 to 5.
        """
        return (
            Review.objects.filter(doctor=self).aggregate(models.Avg("rating"))[
                "rating__avg"
            ]
            or 0.0
        )

    def __str__(self) -> str:
        return f"DR. {str(self.user)}"


class Patient(models.Model):
    """Fields pertaining to the patient.

    Extends CustomUser by means of OneToOne.
    """

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, primary_key=True, on_delete=models.CASCADE
    )
    ssn = models.CharField(
        "Social Security number",
        max_length=11,
        unique=True,
        help_text="Kindly use the following format: <em>NNN-NN-NNNN</em>.",
    )
    date_born = models.DateField("date of birth")

    # def save(self, *args, **kwargs):
    #    if not self.user:
    #        user_data = kwargs.pop("user_data", {})
    #        # the second element is a boolean "created"
    #        self.user = CustomUser.objects.update_or_create(user_data)[0]
    #
    #    super().save(*args, **kwargs)

    def __str__(self) -> str:
        return str(self.user)


class Review(models.Model):
    """A review consisting of a rating and an optional comment.

    The rating is limited to numbers from 0 to 5.
    """

    comment = models.TextField(max_length=500, blank=True)
    rating = models.PositiveSmallIntegerField(
        validators=[MaxValueValidator(limit_value=5)]
    )
    patient = models.ForeignKey(
        Patient, on_delete=models.CASCADE, help_text="Provider of the review."
    )
    doctor = models.ForeignKey(
        Doctor, on_delete=models.CASCADE, help_text="Receiver of the review."
    )
    date_left = models.DateField(
        auto_now_add=True, help_text="Day on which the review was left."
    )

    def __str__(self) -> str:
        return f"Rating of {self.rating} stars from {self.patient} to {self.doctor}."


class TimeSlot(models.Model):
    """A time slot created by a doctor.

    Is considered open when the patient field is None, otherwise
    considered taken if is_confirmed is set to True.
    """

    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    patient = models.ForeignKey(
        Patient, on_delete=models.CASCADE, blank=True, null=True
    )
    day = models.DateField("day of the appointment")
    beginning = models.TimeField("appointment begins at")
    end = models.TimeField("appointment ends at")
    is_confirmed = models.BooleanField("confirmed by the doctor", default=False)
    is_cancelled = models.BooleanField(
        "cancelled by the doctor or the patient", default=False
    )

    @property
    def is_booked(self) -> bool:
        """Return True if the time slot is booked, False otherwise.

        Returns:
            bool: True if patient is set, False if None.
        """
        return bool(self.patient)

    def __str__(self):
        return (
            f"Appointment on {self.day:%B %d, %Y} "
            f"between {self.doctor} and patient {self.patient}."
        )
