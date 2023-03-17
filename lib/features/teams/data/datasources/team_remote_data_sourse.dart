import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:scrumit/core/constant.dart' as cons;
import 'package:scrumit/core/datasource/appwrite.dart';
import 'package:scrumit/core/errors/exceptions.dart';
import 'package:scrumit/core/success/success.dart';
import 'package:scrumit/features/teams/data/models/team_model.dart';

abstract class TeamRemoteDataSourceContract {
  Future<List<MemberShipModel>> getTeamMemberList({required String teamId});
  Future<MemberShipModel> addTeamMember(
      {required String teamId, required String userEmail});
  Future<Success> deleteTeamMember(
      {required String teamId, required String memberShipId});

  Future<List<TeamModel>> getUserTeamsList();
}

class TeamRemoteDataSource implements TeamRemoteDataSourceContract {
  final AppWrite appWrite;
  TeamRemoteDataSource(this.appWrite);

  @override
  Future<MemberShipModel> addTeamMember(
      {required String teamId, required String userEmail}) async {
    final funData = '{"teamId": "$teamId", "userEmail":  "$userEmail"}';
    try {
      final res = await appWrite.getFunctions().createExecution(
          functionId: cons.kAddTeamMemberFunctionId, data: funData.toString());
      debugPrint(res.statusCode.toString());
      debugPrint(res.toMap.toString());
      debugPrint(res.status);
      debugPrint('herre ${res.response}');
      return MemberShipModel.fromJson(jsonDecode(res.response));
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<Success> deleteTeamMember(
      {required String teamId, required String memberShipId}) async {
    try {
      await appWrite
          .getTeams()
          .deleteMembership(teamId: teamId, membershipId: memberShipId);
      return Success();
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<List<MemberShipModel>> getTeamMemberList(
      {required String teamId}) async {
    try {
      final res = await appWrite.getTeams().listMemberships(teamId: teamId);
      List<MemberShipModel> msList = [];
      debugPrint(res.memberships.toString());
      for (var ms in res.memberships) {
        debugPrint(ms.toMap().toString());
        msList.add(MemberShipModel.fromJson(ms.toMap()));
      }
      debugPrint(msList.toString());
      return msList;
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<List<TeamModel>> getUserTeamsList() async {
    try {
      final res = await appWrite.getTeams().list();
      List<TeamModel> tmls = [];
      for (var tm in res.teams) {
        tmls.add(TeamModel.fromJson(tm.toMap()));
      }
      return tmls;
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }
}
