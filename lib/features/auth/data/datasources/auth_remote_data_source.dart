import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';

import 'package:scrumit/core/datasource/appwrite.dart';
import 'package:scrumit/core/errors/exceptions.dart';
import 'package:scrumit/core/success/success.dart';
import 'package:scrumit/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSourceContract {
  Future<SessionModel> login({required String email, required String password});
  Future<AccountModel> signup(
      {String? name, required String email, required String password});
  Future<AccountModel> getAccount();

  Future<Success> logout();
}

class AuthRemoteDataSource implements AuthRemoteDataSourceContract {
  final AppWrite appWrite;
  AuthRemoteDataSource(this.appWrite);

  @override
  Future<AccountModel> getAccount() async {
    try {
      final res = await appWrite.getAccount().get();
      debugPrint('print from AuthRemoteDataSource data layer');
      debugPrint(res.toMap().toString());
      return AccountModel.fromJson(res.toMap());
    } on AppwriteException catch (e) {
      debugPrint(e.toString());
      debugPrint('print from AuthRemoteDataSource data layer');
      throw ServerException();
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('print from AuthRemoteDataSource data layer');
      throw ServerException();
    }
  }

  @override
  Future<SessionModel> login(
      {required String email, required String password}) async {
    try {
      final res = await appWrite
          .getAccount()
          .createEmailSession(email: email, password: password);
      debugPrint('print from AuthRemoteDataSource data layer');
      debugPrint(res.toMap().toString());
      return SessionModel.fromJson(res.toMap());
    } on AppwriteException catch (e) {
      debugPrint('print from AuthRemoteDataSource data layer');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('print from AuthRemoteDataSource data layer');
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<AccountModel> signup(
      {String? name, required String email, required String password}) async {
    try {
      final res = await appWrite
          .getAccount()
          .create(email: email, password: password, userId: ID.unique());
      debugPrint('print from AuthRemoteDataSource data layer');
      return AccountModel.fromJson(res.toMap());
    } on AppwriteException {
      debugPrint('print from AuthRemoteDataSource data layer');
      throw ServerException();
    } catch (e) {
      debugPrint('print from AuthRemoteDataSource data layer');
      throw ServerException();
    }
  }

  @override
  Future<Success> logout() async {
    try {
      await appWrite.getAccount().deleteSessions();
      return Success();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }
}
