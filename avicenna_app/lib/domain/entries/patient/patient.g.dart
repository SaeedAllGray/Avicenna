// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      ssn: json['ssn'] as String,
      birthDate: DateTime.parse(json['birth_date'] as String),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'ssn': instance.ssn,
      'birth_date': instance.birthDate.toIso8601String(),
      'user': instance.user,
    };
