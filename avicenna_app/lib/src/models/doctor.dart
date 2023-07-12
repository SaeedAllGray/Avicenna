import 'package:avicenna_app/src/models/user.dart';

// class Doctor extends User {
//   final String id;
//   final String firstname;
//   final String lastname;
//   final String email;
//   final String phoneNumber;
//   final String profession;
//   final String address;
//   final String username;
//   // TODO: Field for location
//   List<DateTime> schedules = [];

//   Doctor({
//     required this.id,
//     required this.firstname,
//     required this.lastname,
//     required this.email,
//     required this.profession,
//     required this.phoneNumber,
//     required this.address,
//     required this.username,
//   });
// }

class Doctor extends User {
  final int id;
  final String email;
  final String phoneNumber;
  final String profession;
  final String address;
  final String username;
  final String firstname;
  final String lastname;
  final bool isDoctor;

  // TODO: Field for location
  List<DateTime> schedules = [];

  Doctor({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.isDoctor,
    required this.email,
    required this.profession,
    required this.phoneNumber,
    required this.address,
    required this.username,
  });

  factory Doctor.fromJson(List<dynamic> json) => Doctor(
        id: json[0]["pk"],
        firstname: json[0]["fields"]["first_name"],
        lastname: json[0]["fields"]["last_name"],
        isDoctor: json[0]["fields"]["is_doctor"],
        email: json[0]["fields"]["email"],
        username: json[0]["fields"]["username"],
        profession: json[1]["fields"]["specialization"],
        address: json[1]["fields"]["address"],
        phoneNumber: json[1]["fields"]["phone_number"],
      );
}

var a = [
  {
    "model": "avicenna.customuser",
    "pk": 28,
    "fields": {
      "password":
          "pbkdf2_sha256600000LtQ5CCO1PXiB8ErKQ96nSntBhBClflhYXLBekeP90LGugF95vagLUO/CH8M9PWuDE=",
      "last_login": null,
      "is_superuser": false,
      "is_staff": false,
      "is_active": true,
      "date_joined": "2023-07-12T10:04:03Z",
      "email": "ksjhdgjwkq2k@jfhjd.com",
      "username": "1295ab27",
      "first_name": "Panir",
      "last_name": "Mubarak",
      "is_doctor": true,
      "is_patient": false,
      "groups": [],
      "user_permissions": []
    }
  },
  {
    "model": "avicenna.doctor",
    "pk": 28,
    "fields": {
      "phone_number": "+398765456",
      "specialization": "Neurologist",
      "address": "Otto Hans Strasse"
    }
  }
];
