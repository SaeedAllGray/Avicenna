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
    return response.map((data) => TimeSlot.fromJson(data)).toList();
  }

  Future<List<TimeSlot>> fetchBookedTimeSlots(int doctorId) async {
    final List<TimeSlot> timeSlotList = await fetchUserTimeSlots(doctorId);
    return timeSlotList;
  }

  Future<List<TimeSlot>> fetchUserTimeSlots(int doctorId) async {
    List<dynamic> response = await api.fetchUserTimeSlotsEntities(doctorId);
    return response.map((data) => TimeSlot.fromJson(data)).toList();
  }

  Future<TimeSlot> createTimeSlot(TimeSlot timeSlot) async {
    dynamic response = await api.createEntity(timeSlot.toJson());

    return TimeSlot.fromJson(response);
  }

  Future<TimeSlot> updateTimeSlot(TimeSlot timeSlot) async {
    dynamic response = await api.updateEntity(timeSlot.id!, timeSlot.toJson());

    return TimeSlot.fromJson(response);
  }

  @override
  Future<TimeSlot> fetchEntity(int id) {
    throw UnimplementedError();
  }
}
