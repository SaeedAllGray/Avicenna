class Appointment {
  int? doctorId;
  int? patientId;
  int? id;
  DateTime datetime;
  Appointment({
    required this.datetime,
    this.doctorId,
    this.patientId,
    this.id,
  });
  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        datetime: DateTime.parse(json["fields"]["appointment_timestamp"]),
        doctorId: json["fields"]["doctor"],
        patientId: json["fields"]["patient"],
        id: json["pk"],
      );
}

var a = [
  {
    "model": "avicenna.appointment",
    "pk": 5,
    "fields": {
      "doctor": 2,
      "patient": 14,
      "created_timestamp": "2023-07-12T17:56:04.859Z",
      "appointment_timestamp": "2023-07-19T19:55:54Z"
    }
  },
  {
    "model": "avicenna.appointment",
    "pk": 4,
    "fields": {
      "doctor": 2,
      "patient": 14,
      "created_timestamp": "2023-07-12T17:55:54.825Z",
      "appointment_timestamp": "2023-08-20T19:55:53Z"
    }
  },
  {
    "model": "avicenna.appointment",
    "pk": 3,
    "fields": {
      "doctor": 2,
      "patient": 14,
      "created_timestamp": "2023-07-12T17:55:34.762Z",
      "appointment_timestamp": "2023-08-27T19:37:24Z"
    }
  }
];
