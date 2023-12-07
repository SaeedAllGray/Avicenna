import 'dart:math';

import 'package:avicenna_app/src/constants/api_constant.dart';
import 'package:avicenna_app/src/models/appointment.dart';
import 'package:avicenna_app/src/models/patient.dart';
import 'package:avicenna_app/src/models/user.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppointmentRepository {
  Future<void> getAllAppointmentsOfDoctor(int id) async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
      '${ApiConstants.baseUrl}get-appointments/doctor/$id/',
    );

    // List<Doctor> doctors = (jsonDecode(response.data) as List)
    //     .map((e) => Doctor.fromJson(e))
    //     .toList();
    // return doctors;
  }

  Future<void> makeAppointment(int doctorId, DateTime dateTime) async {
    Patient patient = await User.getPatient();
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    await dio.post(
      '${ApiConstants.baseUrl}create-appointment/$doctorId/${patient.id}/${DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(dateTime)}/',
    );

    // List<Doctor> doctors = (jsonDecode(response.data) as List)
    //     .map((e) => Doctor.fromJson(e))
    //     .toList();
    // return doctors;
  }

  Future<List<Appointment>> getAllFreeAppointments() async {
    Random random = Random();

    int numberOfAppointments = random.nextInt(20) + 4;
    List<Appointment> appointments = [];
    for (int j = 0; j < numberOfAppointments; j++) {
      appointments.add(Appointment(
          datetime:
              DateTime.now().add(Duration(days: j + Random().nextInt(50)))));
    }
    return appointments;
  }
}
