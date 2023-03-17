import 'package:scrumit/domain/entities/auth/user.dart';

class UserModel extends User {
  const UserModel({
    String? userName,
    required String userId,
    required String email,
    String? firstName,
    String? lastName,
    int? phone,
  }) : super(
            userName: userName,
            userId: userId,
            email: email,
            firstName: firstName,
            lastName: lastName,
            phone: phone);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      email: map['email'],
      userName: map['userName'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
    );
  }
}
