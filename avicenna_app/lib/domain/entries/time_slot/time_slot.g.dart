// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      confirmed: json['confirmed'] as bool,
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      patientId: json['patient_id'] as int,
      doctorId: json['doctor_id'] as int,
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patientId,
      'doctor_id': instance.doctorId,
      'confirmed': instance.confirmed,
      'date': instance.date.toIso8601String(),
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };
