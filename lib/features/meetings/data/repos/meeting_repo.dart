import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/features/meetings/data/datasources/meeting_datasource.dart';
import 'package:scrumit/features/meetings/domain/contracts/meeting_contract.dart';
import 'package:scrumit/features/meetings/domain/entities/meeting.dart';

class MeetingRepository implements MeetingContract {
  final MeetingRemoteDataSourceContract meetingRemoteDataSourceContract;
  MeetingRepository(this.meetingRemoteDataSourceContract);
  @override
  Future<Either<Failure, Meeting>> joinMeeting(
      {required String projectId, required String userId}) async {
    try {
      final remoteMeeting = await meetingRemoteDataSourceContract.joinMeeting(
          projectId: projectId, userId: userId);

      return Right(remoteMeeting.toDomain());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
