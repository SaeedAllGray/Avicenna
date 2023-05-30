class Doctor {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profession;
  // TODO: Field for location
  List<DateTime> schedules = [];

  Doctor(
      {required this.id,
      required this.name,
      required this.email,
      required this.profession,
      required this.phoneNumber});
}
