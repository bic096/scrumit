import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:scrumit/core/constant.dart';
import 'package:scrumit/core/datasource/appwrite.dart';
import 'package:scrumit/core/errors/exceptions.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/features/meetings/data/dtos/meeting_dto.dart';

abstract class MeetingRemoteDataSourceContract {
  Future<MeetingDto> joinMeeting(
      {required String projectId, required String userId});
}

class MeetingRemoteDataSource implements MeetingRemoteDataSourceContract {
  final AppWrite appWrite;
  MeetingRemoteDataSource(this.appWrite);
  @override
  Future<MeetingDto> joinMeeting(
      {required String projectId, required String userId}) async {
    final funData = '{\"projectId\": \"$projectId\", \"userId\": \"$userId\"}';
    try {
      debugPrint(funData);
      final res = await appWrite.getFunctions().createExecution(
          functionId: kAddMemberToMeetingFunctionId, data: funData.toString());
      debugPrint(res.response.toString());
      return MeetingDto.fromJson(jsonDecode(res.response));
    } on AppwriteException catch (e) {
      debugPrint('appwrite \n $e');
      throw ServerFailure();
    } catch (e) {
      debugPrint('not appwrite \n $e');
      debugPrint(e.toString());
      throw ServerException();
    }
  }
}
