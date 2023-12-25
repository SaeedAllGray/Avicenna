import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Feedback {
  final int id;
  final int rating;
  final int doctorId;
  final int patientId;
  final String? comment;

  Feedback({
    required this.id,
    required this.rating,
    required this.doctorId,
    required this.patientId,
    required this.comment,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
