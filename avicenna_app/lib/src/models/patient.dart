class Patient {
  final String id;
  final String name;
  final String email;
  final String username;

  List<DateTime> schedules = [];

  Patient({
    required this.username,
    required this.id,
    required this.name,
    required this.email,
  });
}
