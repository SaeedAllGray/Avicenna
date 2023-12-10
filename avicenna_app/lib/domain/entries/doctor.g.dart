// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      userInfo: UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      specialization: json['specialization'] as String,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'userInfo': instance.userInfo,
      'specialization': instance.specialization,
    };
