import 'dart:convert';

import 'package:avicenna_app/src/models/appointment.dart';
import 'package:avicenna_app/src/models/doctor.dart';
import 'package:avicenna_app/src/schedule_tab/data/providers/schedule_api.dart';
import 'package:dio/dio.dart';

class ScheduleRepository {
  final ScheduleApi _scheduleApi = ScheduleApi();

  Future<List<Appointment>> getSchedules() async {
    Response response = await _scheduleApi.getSchedules();
    List<dynamic> jsonList = jsonDecode(response.data);

    List<Appointment> appointments = [];
    // List<Appointment> appointments = jsonList.map((json) as{
    //  Appointment appointment =  Appointment.fromJson(json);
    //  appointment.doctor = await
    //   return Appointment.fromJson(json);
    // }).toList();

    for (int i = 0; i < jsonList.length; i++) {
      print("hhhhhhhh");
      Doctor doctor =
          await _scheduleApi.getDoctorById(jsonList[i]["fields"]["doctor"]);
      Appointment appointment = Appointment.fromJson(jsonList[i]);
      appointment.doctor = doctor;
      appointments.add(appointment);
    }
    return appointments;
  }

  Future<bool> deleteSchedule(Appointment appointment) async {
    Response response = await _scheduleApi.deleteSchedule(appointment.id!);
    if (response.statusCode! < 204) {
      return true;
    }
    return false;
  }
}
