import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/sprints/domain/entities/task.dart';
import 'package:scrumit/features/sprints/domain/usecases/sprint_usecases.dart';

class TaskController extends GetxController {
  TaskController(
    this.getTaslDetails,
    this.createTask,
    this.getTaslsList,
    this.updateTask,
  );
  final GetTaslDetails getTaslDetails;
  final CreateTask createTask;
  final GetTaslsList getTaslsList;
  final UpdateTask updateTask;

  RxList<Task> taskList = <Task>[].obs;
  late Rx<Task> task = Task(
          id: 'id',
          usersIds: [],
          status: 'status',
          sprintId: 'sprintId',
          description: 'description',
          type: 'typ',
          priority: 'priority')
      .obs;
  Rx<RequestStatus> requestStatus = RequestStatus.idel.obs;

  Future<void> createTaskFun(
      {required String sprintId, required Task task}) async {
    requestStatus(RequestStatus.looding);
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    final remoteORfail =
        await createTask(params: Params(sprintId: sprintId, task: task));

    remoteORfail.fold((l) {
      requestStatus(RequestStatus.faild);
      Get.dialog(const Center(child: Text('FAild')));
    }, (r) {
      requestStatus(RequestStatus.success);
    });
  }

  Future<void> getTaskListFun({required String sprintId}) async {
    requestStatus(RequestStatus.looding);
    // Get.dialog(const Center(child: CircularProgressIndicator()),
    //     barrierDismissible: false, name: 'getTAsak List dialog');
    final remoteORfail = await getTaslsList(params: Params(sprintId: sprintId));

    remoteORfail.fold((l) {
      requestStatus(RequestStatus.faild);
      // Get.dialog(const Center(child: Text('FAild')));
    }, (r) {
      requestStatus(RequestStatus.success);
      taskList(r);
      if (Get.isDialogOpen != null) {
        if (Get.isDialogOpen!) Get.back();
      }
    });
  }

  Future<void> getTaskDetailsFun({required String taskId}) async {
    requestStatus(RequestStatus.looding);
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    final remoteORfail = await getTaslDetails(params: Params(taskId: taskId));

    remoteORfail.fold((l) {
      requestStatus(RequestStatus.faild);
      Get.dialog(const Center(child: Text('FAild')));
    }, (r) {
      requestStatus(RequestStatus.success);
      task(r);
      if (Get.isDialogOpen != null) {
        if (Get.isDialogOpen!) Get.back();
      }
    });
  }

  Future<void> updateTaskFun(
      {required String taskId, required Task task}) async {
    requestStatus(RequestStatus.looding);
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    final remoteORfail =
        await updateTask(params: Params(taskId: taskId, task: task));

    remoteORfail.fold((l) {
      requestStatus(RequestStatus.faild);
      Get.dialog(const Center(child: Text('FAild')));
    }, (r) {
      requestStatus(RequestStatus.success);
      this.task(r);
      if (Get.isDialogOpen != null) {
        if (Get.isDialogOpen!) Get.back();
      }
    });
  }
}
