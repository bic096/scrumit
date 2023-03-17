import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/core/success/success.dart';
import 'package:scrumit/features/teams/domain/entities/team.dart';

abstract class TeamContract {
  Future<Either<Failure, List<MemberShip>>> getTeamMemberList(
      {required String teamId});

  Future<Either<Failure, Success>> deleteTeamMember(
      {required String teamId, required String memberShipId});

  Future<Either<Failure, MemberShip>> addTeamMember(
      {required String teamId, required String userEmail});

  Future<Either<Failure, List<Team>>> getUserTeamsList();
}
