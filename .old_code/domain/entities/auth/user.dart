class User {
  final String userId;
  final String email;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final int? phone;

  const User({
    this.userName,
    required this.userId,
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
  });
}
