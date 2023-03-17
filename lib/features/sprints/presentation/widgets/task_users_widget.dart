import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/sprints/presentation/controllers/sprint_controller.dart';
import 'package:scrumit/features/sprints/presentation/controllers/task_controller.dart';
import 'package:scrumit/features/teams/presentation/controllers/team_controller.dart';

class TaskUsersWidget extends StatelessWidget {
  TaskUsersWidget({super.key, required this.taskIndex});
  final int taskIndex;
  final tkCtrl = Get.find<TaskController>();
  final sCtrl = Get.find<SprintController>();

  final tmCtrl = Get.find<TeamController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Obx(
        () => ListView.builder(
            itemCount: tmCtrl.teamMemberList.length,
            itemBuilder: ((context, index) {
              return Obx(() {
                return ListTile(
                  trailing: tkCtrl.taskList[taskIndex].usersIds
                          .contains(tmCtrl.teamMemberList[index].userId)
                      ? IconButton(
                          onPressed: () async {
                            var ls = tkCtrl.taskList[taskIndex].usersIds;
                            ls.remove(tmCtrl.teamMemberList[index].userId);
                            tkCtrl.taskList[taskIndex].copyWith(usersIds: ls);
                            await tkCtrl.updateTaskFun(
                                taskId: tkCtrl.taskList[taskIndex].id,
                                task: tkCtrl.taskList[taskIndex]);
                            tkCtrl.getTaskListFun(
                                sprintId: sCtrl.currentSprintId);
                          },
                          icon: const Icon(Icons.cancel))
                      : IconButton(
                          onPressed: () async {
                            var ls = tkCtrl.taskList[taskIndex].usersIds;
                            ls.add(tmCtrl.teamMemberList[index].userId);
                            tkCtrl.taskList[taskIndex].copyWith(usersIds: ls);
                            await tkCtrl.updateTaskFun(
                                taskId: tkCtrl.taskList[taskIndex].id,
                                task: tkCtrl.taskList[taskIndex]);
                            tkCtrl.getTaskListFun(
                                sprintId: sCtrl.currentSprintId);
                          },
                          icon: const Icon(Icons.add)),
                  title: Text(tmCtrl.teamMemberList[index].userEmail),
                );
              });
            })),
      ),
    );
  }
}
