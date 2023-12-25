import 'package:json_annotation/json_annotation.dart';

part 'time_slot.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TimeSlot {
  final int id;
  final int patientId;
  final int doctorId;
  final bool confirmed;
  final DateTime date;
  final DateTime start;
  final DateTime end;

  TimeSlot({
    required this.confirmed,
    required this.id,
    required this.date,
    required this.start,
    required this.end,
    required this.patientId,
    required this.doctorId,
  });
  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}
