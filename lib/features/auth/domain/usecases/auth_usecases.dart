import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/core/success/success.dart';
import 'package:scrumit/core/usecases/usercase.dart';
import 'package:scrumit/features/auth/domain/contracts/auth_contract.dart';
import 'package:scrumit/features/auth/domain/entities/user.dart';

class Params extends Equatable {
  final User? user;
  final String? email;
  final String? password;
  final String? name;

  const Params({this.user, this.email, this.password, this.name});

  @override
  List<Object?> get props => [user];
}

class Login implements UseCase<User, Params> {
  final AuthContract authContract;
  Login(this.authContract);

  @override
  Future<Either<Failure, User>> call({required Params params}) async {
    return await authContract.login(
        email: params.email!, password: params.password!);
  }
}

class Signup implements UseCase<User, Params> {
  final AuthContract authContract;
  Signup(this.authContract);
  @override
  Future<Either<Failure, User>> call({required Params params}) async {
    return await authContract.signup(
        email: params.email!, password: params.password!);
  }
}

class GetAccount implements UseCase<User, NoParams> {
  final AuthContract authContract;
  GetAccount(this.authContract);
  @override
  Future<Either<Failure, User>> call({required NoParams params}) async {
    return await authContract.getAccount();
  }
}

class Logout {
  final AuthContract authContract;
  Logout(this.authContract);

  Future<Either<Failure, Success>> call() async {
    return await authContract.logout();
  }
}
