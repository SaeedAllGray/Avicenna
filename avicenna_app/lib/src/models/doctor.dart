class Doctor {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profession;
  final String address;
  final String username;
  // TODO: Field for location
  List<DateTime> schedules = [];

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.profession,
    required this.phoneNumber,
    required this.address,
    required this.username,
  });
}

class DoctorFake {
  final String id;
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

  DoctorFake({
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
}
