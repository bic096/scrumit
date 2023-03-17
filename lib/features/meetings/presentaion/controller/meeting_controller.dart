import 'package:get/get.dart';
import 'package:scrumit/features/meetings/domain/usecases/meetings_usecases.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';

class MeetingController extends GetxController {
  final JoinMeeting joinMeeting;
  MeetingController(this.joinMeeting);

  late String roomName;
  late String authToken;
  Rx<RequestStatus> requestStatus = RequestStatus.idel.obs;
  Future<bool> joinMeetingFun(
      {required String projectId, required String userId}) async {
    requestStatus(RequestStatus.looding);
    final res =
        await joinMeeting(params: Params(projectId: projectId, userId: userId));
    bool ret = false;
    res.fold((l) {
      requestStatus(RequestStatus.faild);
      ret = false;
    }, (r) {
      roomName = r.roomName;
      authToken = r.authToken;
      requestStatus(RequestStatus.success);
      ret = true;
    });
    return ret;
  }
}
