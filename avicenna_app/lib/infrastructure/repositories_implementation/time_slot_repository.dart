import 'dart:developer';

import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:avicenna_app/domain/repositories/entity_repository.dart';
import 'package:avicenna_app/infrastructure/data_sources/remote/time_slot_remote_data_source.dart';

class TimeSlotRepository
    implements EntityRepository<TimeSlot, TimeSlotRemoteDataSource> {
  @override
  TimeSlotRemoteDataSource api = TimeSlotRemoteDataSource();

  @override
  Future<List<TimeSlot>> fetchEntities() async {
    List<dynamic> response = await api.fetchEntities();
    log(response.toString());
    print(response.map((data) => TimeSlot.fromJson(data).start).toList());
    return response.map((data) => TimeSlot.fromJson(data)).toList();
  }

  Future<List<TimeSlot>> fetchDoctorTimeSlots(int doctorId) async {
    List<dynamic> response = await api.fetchDoctorEntities(doctorId);
    log(response.toString());
    return response.map((data) => TimeSlot.fromJson(data)).toList();
  }

  Future<List<TimeSlot>> fetchPatientTimeSlots(int patientId) async {
    List<dynamic> response = await api.fetchPatientEntities(patientId);
    log(response.toString());
    return response.map((data) => TimeSlot.fromJson(data)).toList();
  }

  @override
  Future<TimeSlot> fetchEntity() {
    // TODO: implement fetchEntity
    throw UnimplementedError();
  }
}
