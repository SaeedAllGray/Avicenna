// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      isConfirmed: json['is_confirmed'] as bool?,
      isBooked: json['is_booked'] as bool?,
      id: json['id'] as int?,
      day: DateTime.parse(json['day'] as String),
      beginning: TimeSlot._timeOfDayFromJson(json['beginning'] as String),
      end: TimeSlot._timeOfDayFromJson(json['end'] as String),
      patientId: json['patient_id'] as int?,
      isCancelled: json['is_cancelled'] as bool?,
      doctorId: json['doctor_id'] as int,
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('patient_id', instance.patientId);
  val['doctor_id'] = instance.doctorId;
  writeNotNull('is_confirmed', instance.isConfirmed);
  writeNotNull('is_cancelled', instance.isCancelled);
  writeNotNull('is_booked', instance.isBooked);
  val['day'] = TimeSlot._dateTimeToJson(instance.day);
  val['beginning'] = TimeSlot._timeOfDayToJson(instance.beginning);
  val['end'] = TimeSlot._timeOfDayToJson(instance.end);
  return val;
}
