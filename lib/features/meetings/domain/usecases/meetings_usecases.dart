import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/core/usecases/usercase.dart';
import 'package:scrumit/features/meetings/domain/contracts/meeting_contract.dart';
import 'package:scrumit/features/meetings/domain/entities/meeting.dart';

class Params {
  final String? projectId;
  final String? userId;
  Params({this.projectId, this.userId});
}

class JoinMeeting implements UseCase<Meeting, Params> {
  final MeetingContract meetingContract;
  JoinMeeting(this.meetingContract);
  @override
  Future<Either<Failure, Meeting>> call({required Params params}) async {
    return await meetingContract.joinMeeting(
        projectId: params.projectId!, userId: params.userId!);
  }
}
