import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/exceptions.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/core/success/success.dart';
import 'package:scrumit/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:scrumit/features/auth/domain/contracts/auth_contract.dart';
import 'package:scrumit/features/auth/domain/entities/user.dart';

class AuthRepository implements AuthContract {
  final AuthRemoteDataSourceContract authRemoteDataSourceContract;
  AuthRepository(this.authRemoteDataSourceContract);

  @override
  Future<Either<Failure, User>> getAccount() async {
    try {
      final remoteAuth = await authRemoteDataSourceContract.getAccount();
      debugPrint('print from AuthRepository data layer');
      debugPrint(remoteAuth.toString());
      return Right(remoteAuth.toDomain());
    } on ServerException {
      debugPrint('print from AuthRepository data layer');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(
      {required String email, required String password}) async {
    try {
      final remoteLogin = await authRemoteDataSourceContract.login(
          email: email, password: password);
      debugPrint('print from AuthRepository data layer');
      debugPrint(remoteLogin.toString());
      return Right(remoteLogin.toDomain());
    } on ServerException catch (e) {
      debugPrint(e.toString());
      debugPrint('print from AuthRepository data layer');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signup(
      {String? name, required String email, required String password}) async {
    try {
      final remoteSignup = await authRemoteDataSourceContract.signup(
          name: name, email: email, password: password);
      debugPrint('print from AuthRepository data layer');
      return Right(remoteSignup.toDomain());
    } on ServerException {
      debugPrint('print from AuthRepository data layer');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Success>> logout() async {
    try {
      await authRemoteDataSourceContract.logout();
      return Right(Success());
    } catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure());
    }
  }
}
