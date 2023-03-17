import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/sprints/domain/entities/sprint.dart';
import 'package:scrumit/features/sprints/domain/usecases/sprint_usecases.dart';

class SprintController extends GetxController {
  final CreateSprint createSprint;
  final GetSprintDetails getSprintDetails;
  final GetSprintsList getSprintsList;
  final UpdateSprint updateSprint;

  SprintController(this.createSprint, this.getSprintDetails,
      this.getSprintsList, this.updateSprint);
  var currentSprintId = '';
  Rx<bool> thereIscurrentsprint = false.obs;
  var sprintList = <Sprint>[].obs;

  Rx<bool> sprintEditable = false.obs;
  // ignore: prefer_final_fields
  late Rx<Sprint> _currentSprint = Sprint(
    id: 'id',
    projecId: 'projecId',
    sprintNum: 0,
    startingDate: DateTime.now(),
    endDate: DateTime.now(),
    status: 'status',
    dailyScrum: [],
    tasks: [],
  ).obs;

  late Rx<Sprint> sprint = Sprint(
    id: 'id',
    projecId: 'projecId',
    sprintNum: 0,
    startingDate: DateTime.now(),
    endDate: DateTime.now(),
    status: 'status',
    dailyScrum: [],
    tasks: [],
  ).obs;
  Rx<RequestStatus> requestStatus = RequestStatus.idel.obs;

  void sprintCopyWith(
      {DateTime? starDate,
      DateTime? endDate,
      String? projectId,
      int? sprintNum,
      String? sprintReview,
      String? sprintPlaning,
      String? retrospective,
      String? status}) {
    sprint(sprint.value.copyWith(
      projectId: projectId,
      endDate: endDate,
      sprintNum: sprintNum,
      retrospective: retrospective,
      sprintPlaning: sprintPlaning,
      sprintReview: sprintReview,
      startingDate: starDate,
      status: status,
    ));
  }

  void currentSprintCopyWith(
      {DateTime? starDate,
      DateTime? endDate,
      String? projectId,
      int? sprintNum,
      String? sprintReview,
      String? sprintPlaning,
      String? retrospective,
      String? status}) {
    _currentSprint(_currentSprint.value.copyWith(
      projectId: projectId,
      endDate: endDate,
      sprintNum: sprintNum,
      retrospective: retrospective,
      sprintPlaning: sprintPlaning,
      sprintReview: sprintReview,
      startingDate: starDate,
      status: status,
    ));
  }

  Future<void> createSprintFun(
      {required String projectId, required Sprint sprint}) async {
    requestStatus(RequestStatus.looding);
    // Get.dialog(const Center(child: CircularProgressIndicator()),
    //     barrierDismissible: false);
    final remoteORfail = await createSprint(
        params: Params(projectId: projectId, sprint: sprint));

    remoteORfail.fold((l) {
      requestStatus(RequestStatus.faild);
      // Get.dialog(const Center(child: Text('FAild')));
    }, (r) {
      requestStatus(RequestStatus.success);
    });
  }

  Future<void> getSprintListFun({required String projectId}) async {
    requestStatus(RequestStatus.looding);
    // Get.dialog(const Center(child: CircularProgressIndicator()),
    //     barrierDismissible: false);
    final remoteORfail =
        await getSprintsList(params: Params(projectId: projectId));

    remoteORfail.fold((l) {
      requestStatus(RequestStatus.faild);

      // Get.dialog(const Center(child: Text('FAild')));
    }, (r) {
      if (r.isNotEmpty) {
        if (r.indexWhere(
              (item) => item.status == 'current',
            ) !=
            -1) {
          currentSprintId = r[r.indexWhere(
            (item) => item.status == 'current',
          )]
              .id;
          thereIscurrentsprint(true);
        } else {
          thereIscurrentsprint(false);
        }
      }
      if (r.isEmpty) {
        thereIscurrentsprint(false);
      }
      debugPrint('\n\n$currentSprintId\n\n\n');
      requestStatus(RequestStatus.success);
      sprintList(r);
      // if (Get.isDialogOpen != null) {
      //   if (Get.isDialogOpen!) Get.back();
      // }
    });
  }

  Future<void> getSprintDetailsFun({required String sprintId}) async {
    requestStatus(RequestStatus.looding);
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    final remoteORfail =
        await getSprintDetails(params: Params(sprintId: sprintId));

    remoteORfail.fold((l) {
      requestStatus(RequestStatus.faild);
      Get.dialog(const Center(child: Text('FAild')));
    }, (r) {
      requestStatus(RequestStatus.success);
      currentSprint = r;
      if (Get.isDialogOpen != null) {
        if (Get.isDialogOpen!) Get.back();
      }
    });
  }

  Future<void> updateSprintFun(
      {required String sprintId, required Sprint sprint}) async {
    requestStatus(RequestStatus.looding);
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    final remoteORfail =
        await updateSprint(params: Params(sprintId: sprintId, sprint: sprint));

    remoteORfail.fold((l) {
      requestStatus(RequestStatus.faild);
      Get.dialog(const Center(child: Text('FAild')));
    }, (r) {
      requestStatus(RequestStatus.success);
      currentSprint = r;
      if (Get.isDialogOpen != null) {
        if (Get.isDialogOpen!) Get.back();
      }
    });
  }

  set currentSprint(Sprint sprint) => _currentSprint(sprint);
  Sprint get currentSprint => _currentSprint.value;
}
