import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/core/success/success.dart';
import 'package:scrumit/core/usecases/usercase.dart';
import 'package:scrumit/features/teams/domain/contracts/team_contract.dart';
import 'package:scrumit/features/teams/domain/entities/team.dart';

class Params {
  final String? teamId;
  final String? memberShipId;
  final String? userEmail;
  const Params({this.teamId, this.memberShipId, this.userEmail});

  // @override
  // List<Object?> get props => [];
}

class GetTeamMemberList implements UseCase<List<MemberShip>, Params> {
  final TeamContract teamContract;
  GetTeamMemberList(this.teamContract);
  @override
  Future<Either<Failure, List<MemberShip>>> call(
      {required Params params}) async {
    return await teamContract.getTeamMemberList(teamId: params.teamId!);
  }
}

//TODO: implemented using cloud function
///{caoiti}
class AddTeamMember implements UseCase<MemberShip, Params> {
  final TeamContract teamContract;
  AddTeamMember(this.teamContract);
  @override
  Future<Either<Failure, MemberShip>> call({required Params params}) async {
    return await teamContract.addTeamMember(
        teamId: params.teamId!, userEmail: params.userEmail!);
  }
}

class DeleteTeamMember implements UseCase<Success, Params> {
  final TeamContract teamContract;
  DeleteTeamMember(this.teamContract);
  @override
  Future<Either<Failure, Success>> call({required Params params}) async {
    return await teamContract.deleteTeamMember(
        teamId: params.teamId!, memberShipId: params.memberShipId!);
  }
}

class GetUSerTeamsList implements UseCase<List<Team>, NoParams> {
  final TeamContract teamContract;
  GetUSerTeamsList(this.teamContract);
  @override
  Future<Either<Failure, List<Team>>> call({required NoParams params}) async {
    return await teamContract.getUserTeamsList();
  }
}
