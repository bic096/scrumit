import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/core/success/success.dart';
import 'package:scrumit/features/auth/domain/entities/user.dart';

abstract class AuthContract {
  Future<Either<Failure, User>> login(
      {required String email, required String password});

  Future<Either<Failure, User>> signup(
      {String? name, required String email, required String password});

  Future<Either<Failure, User>> getAccount();

  Future<Either<Failure, Success>> logout();
}
