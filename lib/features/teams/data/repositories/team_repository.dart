import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/exceptions.dart';
import 'package:scrumit/core/success/success.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/features/teams/data/datasources/team_remote_data_sourse.dart';
import 'package:scrumit/features/teams/domain/contracts/team_contract.dart';
import 'package:scrumit/features/teams/domain/entities/team.dart';

class TeamRepository implements TeamContract {
  final TeamRemoteDataSourceContract teamRemoteDataSourceContract;
  TeamRepository(this.teamRemoteDataSourceContract);
  @override
  Future<Either<Failure, MemberShip>> addTeamMember(
      {required String teamId, required String userEmail}) async {
    try {
      final remoteMembership = await teamRemoteDataSourceContract.addTeamMember(
          teamId: teamId, userEmail: userEmail);
      return Right(remoteMembership.toDomain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Success>> deleteTeamMember(
      {required String teamId, required String memberShipId}) async {
    try {
      await teamRemoteDataSourceContract.deleteTeamMember(
          teamId: teamId, memberShipId: memberShipId);
      return Right(Success());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MemberShip>>> getTeamMemberList(
      {required String teamId}) async {
    try {
      final remoteMembership =
          await teamRemoteDataSourceContract.getTeamMemberList(teamId: teamId);
      List<MemberShip> msList = [];
      for (var i in remoteMembership) {
        msList.add(i.toDomain());
      }
      return Right(msList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Team>>> getUserTeamsList() async {
    try {
      final remoteTeam = await teamRemoteDataSourceContract.getUserTeamsList();
      List<Team> tmls = [];
      for (var tm in remoteTeam) {
        tmls.add(tm.toDomain());
      }
      return Right(tmls);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
