import 'dart:convert';

import 'package:avicenna_app/src/models/doctor.dart';
import 'package:avicenna_app/src/models/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class User {
  static Future<Patient> getPatient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonstr = prefs.getString("userinfo");
    List<dynamic> json = jsonDecode(jsonstr!);
    Patient patient = Patient.fromJson(json);
    return patient;
  }

  static Future<Doctor> getDoctor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonstr = prefs.getString("userinfo");
    List<dynamic> json = jsonDecode(jsonstr!);
    Doctor doctor = Doctor.fromJson(json);
    return doctor;
  }
}
