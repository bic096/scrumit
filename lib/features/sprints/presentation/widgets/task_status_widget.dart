import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/sprints/presentation/controllers/sprint_controller.dart';
import 'package:scrumit/features/sprints/presentation/controllers/task_controller.dart';

class TaskStatusWidget extends StatelessWidget {
  TaskStatusWidget({super.key, required this.taskIndex});
  final tkCtrl = Get.find<TaskController>();
  final sCtrl = Get.find<SprintController>();
  final int taskIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  await tkCtrl.updateTaskFun(
                      taskId: tkCtrl.taskList[taskIndex].id,
                      task: tkCtrl.taskList[taskIndex].copyWith(
                          status: index == 0
                              ? 'todo'
                              : index == 1
                                  ? 'doing'
                                  : 'done'));
                  tkCtrl.getTaskListFun(sprintId: sCtrl.currentSprint.id);
                },
                child: Obx(() {
                  // tkCtrl.task;
                  return ListTile(
                    // shape: (tkCtrl.taskList[taskIndex].status == 'todo' &&
                    //             index == 0) ||
                    //         (tkCtrl.taskList[taskIndex].status == 'doing' &&
                    //             index == 1) ||
                    //         (tkCtrl.taskList[taskIndex].status == 'done' &&
                    //             index == 2)
                    //     ? Border.all(color: Colors.green)
                    //     : null,
                    selected: (tkCtrl.taskList[taskIndex].status == 'todo' &&
                                index == 0) ||
                            (tkCtrl.taskList[taskIndex].status == 'doing' &&
                                index == 1) ||
                            (tkCtrl.taskList[taskIndex].status == 'done' &&
                                index == 2)
                        ? true
                        : false,

                    // color: index == 0
                    //     ? Colors.red
                    //     : index == 1
                    //         ? Colors.yellow
                    //         : Colors.green,
                    title: Center(
                      heightFactor: 2,
                      child: Text(index == 0
                          ? 'TODO'
                          : index == 1
                              ? 'DOING'
                              : 'DONE'),
                    ),
                  );
                }),
              )),
    );
  }
}
