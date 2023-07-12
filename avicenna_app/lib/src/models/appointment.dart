class Appointment {
  String? doctorId;
  String? patientId;
  DateTime datetime;
  Appointment({
    required this.datetime,
    this.doctorId,
    this.patientId,
  });
  // factory Appointment.fromJson(List<dynamic> json) =>Appointment(json, doctorId, patientId);
}
