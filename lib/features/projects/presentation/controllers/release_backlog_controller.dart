import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/features/projects/domain/entities/release_backlog.dart';
import 'package:scrumit/features/projects/domain/usecases/project_usecases.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';

class ReleaseBacklogController extends GetxController {
  final GetReleaseBacklog getReleaseBacklog;
  final GetReleaseBacklogList getReleaseBacklogList;
  final CreateReleaseBacklog createReleaseBacklog;
  final UpdateReleaseBacklog updateReleaseBacklog;
  ReleaseBacklogController(
      {required this.createReleaseBacklog,
      required this.getReleaseBacklog,
      required this.getReleaseBacklogList,
      required this.updateReleaseBacklog});

  final pCtrl = Get.find<ProjectController>();

  Rx<ReleaseBacklog> releaseBacklog = ReleaseBacklog(
          id: '',
          createdAt: DateTime.now(),
          projectId: '',
          name: '',
          description: '',
          type: '',
          priority: '')
      .obs;
  RxList<ReleaseBacklog> releaseBacklogList = <ReleaseBacklog>[].obs;
  Rx<RequestStatus> requestStatus = RequestStatus.idel.obs;

  void releaseCopyWith({String? name, String? description, String? priority}) {
    releaseBacklog(releaseBacklog.value
        .copyWith(name: name, description: description, priority: priority));
  }

  @override
  void onInit() {
    listReleaseBacklogs(pCtrl.currentProjectId);
    super.onInit();
  }

  void listReleaseBacklogs(String projectId) async {
    requestStatus(RequestStatus.looding);
    final failureOrList =
        await getReleaseBacklogList(params: Params(projectId: projectId));
    failureOrList.fold((Failure l) {
      requestStatus(RequestStatus.faild);
      debugPrint(l.toString());
    }, (List<ReleaseBacklog> r) {
      requestStatus(RequestStatus.success);
      debugPrint(r.toString());
      // debugPrint(r[1].createdAt!.toIso8601String());
      releaseBacklogList(r);
    });
  }

  void releaseBacklogDetails(String releaseBacklogId) async {
    final failureOrProject = await getReleaseBacklog(
        params: Params(releaseBacklogId: releaseBacklogId));

    failureOrProject.fold((l) {
      requestStatus(RequestStatus.faild);
    }, (ReleaseBacklog r) {
      requestStatus(RequestStatus.success);
      debugPrint(r.toString());
      // debugPrint(r[1].createdAt!.toIso8601String());
      // projectList(r);
      releaseBacklog(r);
    });
  }

//TODO: add project id param
  Future<void> addReleaseBacklog(ReleaseBacklog releaseBacklog) async {
    final failureOrproject = await createReleaseBacklog(
        params: Params(releaseBacklog: releaseBacklog));
    failureOrproject.fold((l) {
      requestStatus(RequestStatus.faild);
    }, (r) {
      requestStatus(RequestStatus.success);
      this.releaseBacklog(r);
    });
  }

  Future<void> updateReleaseBacklogFun(
      ReleaseBacklog releaseBacklog, String id) async {
    requestStatus(RequestStatus.looding);
    final failureOrSuccess = await updateReleaseBacklog(
        params: Params(releaseBacklog: releaseBacklog, releaseBacklogId: id));

    failureOrSuccess.fold((l) {
      requestStatus(RequestStatus.faild);
    }, (r) {
      requestStatus(RequestStatus.success);
      this.releaseBacklog(r);
    });
  }
}
