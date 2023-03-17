class User {
  final String userId;
  final String? name;
  final String email;

  User({
    this.name,
    required this.userId,
    required this.email,
  });

  User copyWith(
      {String? name, String? userId, String? email, String? password}) {
    return User(
      name: name ?? this.name,
      userId: userId ?? this.userId,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return '''
                userId: $userId,
                  name: $name,
                emamil: $email,
           ''';
  }
}
