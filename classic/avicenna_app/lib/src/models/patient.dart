import 'package:avicenna_app/src/models/user.dart';

class Patient extends User {
  final int id;
  final String email;
  final String username;
  final String firstname;
  final String lastname;
  final bool isDoctor;
  final String socialSecurityNumber;

  List<DateTime>? schedules = [];

  Patient({
    required this.firstname,
    required this.lastname,
    required this.isDoctor,
    required this.socialSecurityNumber,
    required this.username,
    required this.id,
    required this.email,
    this.schedules,
  });
  // factory Patient.fromJson(Map<String, dynamic> json) => Patient(
  //       id: json["pk"],
  //       firstname: json["first_name"],
  //       lastname: json["last_name"],
  //       isDoctor: json["is_doctor"],
  //       email: json["email"],
  //       username: json["username"],
  //       socialSecurityNumber: json["ssn"],
  //     );
  factory Patient.fromJson(List<dynamic> json) => Patient(
        id: json[1]["pk"],
        firstname: json[0]["fields"]["first_name"],
        lastname: json[0]["fields"]["last_name"],
        isDoctor: false,
        email: json[0]["fields"]["email"],
        username: json[0]["fields"]["username"],
        socialSecurityNumber: json[1]["fields"]["ssn"],
      );
}

var a = [
  {
    "model": "avicenna.customuser",
    "pk": 8,
    "fields": {
      "password":
          "pbkdf2_sha2566000005zQn81Co2v2AjX9ROCAVxuNIPu38vFlG4F7MSmeKsJ6HR5+k/BVbJT1wmP+46p+S4=",
      "last_login": null,
      "is_superuser": false,
      "is_staff": false,
      "is_active": true,
      "date_joined": "2023-07-11T12:43:35Z",
      "email": "tu@tu.com",
      "username": "9072bdda",
      "first_name": "Test",
      "last_name": "User",
      "is_doctor": false,
      "is_patient": true,
      "groups": [],
      "user_permissions": []
    }
  },
  {
    "model": "avicenna.patient",
    "pk": 8,
    "fields": {"ssn": "98762"}
  }
];
