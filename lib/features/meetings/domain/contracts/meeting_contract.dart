import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/features/meetings/domain/entities/meeting.dart';

abstract class MeetingContract {
  Future<Either<Failure, Meeting>> joinMeeting(
      {required String projectId, required String userId});
}
