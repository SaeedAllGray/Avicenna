// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
      id: json['id'] as int,
      rating: json['rating'] as int,
      doctorId: json['doctor_id'] as int,
      patientId: json['patient_id'] as int,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'doctor_id': instance.doctorId,
      'patient_id': instance.patientId,
      'comment': instance.comment,
    };
