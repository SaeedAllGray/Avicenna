class Patient {
  final String id;
  final String name;
  final String email;
  final String username;
  final String firstname;
  final String lastname;
  final bool isDoctor;
  final String socialSecurityNumber;

  List<DateTime> schedules = [];

  Patient({
    required this.firstname,
    required this.lastname,
    required this.isDoctor,
    required this.socialSecurityNumber,
    required this.username,
    required this.id,
    required this.name,
    required this.email,
  });
}
