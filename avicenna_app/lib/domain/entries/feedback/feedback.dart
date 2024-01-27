import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Feedback {
  int? id;
  final int rating;
  int? doctorId;
  int? patientId;
  final String? comment;

  Feedback({
    this.id,
    required this.rating,
    this.doctorId,
    this.patientId,
    this.comment,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
