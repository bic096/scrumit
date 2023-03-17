import 'package:scrumit/features/auth/domain/entities/user.dart';

class SessionModel {
  final String? userId;
  final String? name;
  final String? email;
  final String? createdAt;
  final String? updatedAt;

  SessionModel({
    this.userId,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        userId: json['userId'],
        name: json['name'],
        email: json['providerUid'],
        createdAt: json['\$createdAt'],
        updatedAt: json['\$updatedAt'],
      );

  factory SessionModel.fromDomain(User user) {
    return SessionModel(
      userId: user.userId,
      name: user.name,
      email: user.email,
    );
  }

  User toDomain() {
    return User(userId: userId!, email: email!);
  }

  @override
  String toString() {
    return '''  print from  SessionModel datalayer
        userId: $userId,
        name: $name,
        email: $email,
         ''';
  }
}

class AccountModel {
  final String? userId;
  final String? name;
  final String? email;
  AccountModel({
    this.userId,
    this.name,
    this.email,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        userId: json['\$id'],
        name: json['name'],
        email: json['email'],
      );

  factory AccountModel.fromDomain(User user) {
    return AccountModel(
      userId: user.userId,
      name: user.name,
      email: user.email,
    );
  }
  User toDomain() {
    return User(userId: userId!, email: email!);
  }

  @override
  String toString() {
    return ''' print from  AccountModel datalayer
        userId: $userId,
        name: $name,
        email: $email,
         ''';
  }
}
