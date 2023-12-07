class UserInfo {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String? email;

  UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    this.email,
  });
}
