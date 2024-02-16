// ignore_for_file: constant_identifier_names

import 'package:avicenna_app/infrastructure/data_sources/local/local_source.dart';

class ApiConstants {
  static const String baseUrl = 'https://p1car00n.eu.pythonanywhere.com/api/';
  static const String TOKEN = 'token';
  static const String USER = 'user';
  static const String TYPE = 'type';
  static const String DOCTOR = 'doctors';
  static const String PATIENT = 'patient';
  static const String PATIENT_ID = 'patient_id';
  static const String DOCTOR_ID = 'doctor_id';

  static String userToken = '';

  static String get getToken {
    return userToken;
  }

  static Future<void> setToken() async {
    userToken = await LocalSource.getInstance().getToken() ?? '';
  }
}
