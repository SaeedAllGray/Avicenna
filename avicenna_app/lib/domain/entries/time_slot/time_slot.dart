import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_slot.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class TimeSlot {
  final int? id;
  final int? patientId;
  final int doctorId;
  final bool? isConfirmed;
  final bool? isBooked;
  @JsonKey(toJson: _dateTimeToJson)
  final DateTime day;

  @JsonKey(fromJson: _timeOfDayFromJson, toJson: _timeOfDayToJson)
  final TimeOfDay beginning;

  @JsonKey(fromJson: _timeOfDayFromJson, toJson: _timeOfDayToJson)
  final TimeOfDay end;

  TimeSlot({
    this.isConfirmed,
    this.isBooked,
    this.id,
    required this.day,
    required this.beginning,
    required this.end,
    this.patientId,
    required this.doctorId,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);

  static TimeOfDay _timeOfDayFromJson(String json) {
    final parts = json.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  static String _timeOfDayToJson(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  static String _dateTimeToJson(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
