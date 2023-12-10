// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      userInfo: UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      birthDate: DateTime.parse(json['birthDate'] as String),
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'userInfo': instance.userInfo,
      'birthDate': instance.birthDate.toIso8601String(),
    };
