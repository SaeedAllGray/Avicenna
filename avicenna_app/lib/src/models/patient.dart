class Patient {
  final String id;
  final String name;
  final String email;
  List<DateTime> schedules = [];

  Patient({
    required this.id,
    required this.name,
    required this.email,
  });
}
