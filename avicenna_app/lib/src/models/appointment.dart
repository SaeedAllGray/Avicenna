import 'package:avicenna_app/src/models/doctor.dart';

class Appointment {
  Doctor doctor;
  DateTime datetime;
  Appointment(this.doctor, this.datetime);
}
