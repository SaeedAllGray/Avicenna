// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      ssn: json['ssn'] as String,
      dateBorn: json['date_born'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'ssn': instance.ssn,
      'date_born': instance.dateBorn,
      'user': instance.user,
    };
