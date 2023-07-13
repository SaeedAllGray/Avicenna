import 'dart:convert';

import 'package:avicenna_app/src/models/appointment.dart';
import 'package:avicenna_app/src/schedule_tab/data/providers/schedule_api.dart';
import 'package:dio/dio.dart';

class ScheduleRepository {
  final ScheduleApi _scheduleApi = ScheduleApi();

  Future<List<Appointment>> getSchedules() async {
    Response response = await _scheduleApi.getSchedules();
    List<dynamic> jsonList = jsonDecode(response.data);

    List<Appointment> appointments =
        jsonList.map((json) => Appointment.fromJson(json)).toList();

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
