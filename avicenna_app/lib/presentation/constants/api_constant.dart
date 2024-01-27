import 'package:avicenna_app/infrastructure/data_sources/local/local_source.dart';

class ApiConstants {
  static const String baseUrl = 'http://10.211.9.32:8000/api/';
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
