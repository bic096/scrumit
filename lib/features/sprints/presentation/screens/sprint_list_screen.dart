import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/sprints/domain/entities/sprint.dart';
import 'package:scrumit/features/sprints/presentation/controllers/sprint_controller.dart';
import 'package:scrumit/features/sprints/presentation/controllers/task_controller.dart';
import 'package:scrumit/features/sprints/presentation/screens/add_sprint_screen.dart';
import 'package:scrumit/features/sprints/presentation/screens/sprint_screen.dart';

class SprintListScreen extends StatelessWidget {
  SprintListScreen({super.key});
  final pCtrl = Get.find<ProjectController>();
  final sCtrl = Get.find<SprintController>();
  final tkCtrl = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Sprint List'),
        ),
        body: Obx(
          (() => SizedBox(
                child: sCtrl.requestStatus.value == RequestStatus.idel ||
                        sCtrl.requestStatus.value == RequestStatus.looding
                    ? const Center(child: CircularProgressIndicator())
                    : sCtrl.sprintList.isEmpty
                        ? const Text('No Data')
                        : ListView.builder(
                            itemCount: sCtrl.sprintList.length,
                            itemBuilder: (contex, item) {
                              return Obx(
                                () => Card(
                                  elevation: 1,
                                  child: ListTile(
                                    onTap: () {
                                      sCtrl.currentSprint =
                                          sCtrl.sprintList[item];
                                      tkCtrl.getTaskListFun(
                                          sprintId: sCtrl.currentSprint.id);
                                      Get.to(() => SprintScreen());
                                    },
                                    leading: Text(
                                        '${sCtrl.sprintList[item].sprintNum}'),
                                    title: Text(
                                        'starting at :  ${sCtrl.sprintList[item].startingDate.toLocal()}'),
                                    subtitle: Text(
                                        'end at ;  ${sCtrl.sprintList[item].endDate.toLocal()}'),
                                    trailing:
                                        Text(sCtrl.sprintList[item].status),
                                  ),
                                ),
                              );
                            }),
              )),
        ),
        floatingActionButton: sCtrl.thereIscurrentsprint.value == true
            ? null
            : FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () async {
                  sCtrl.sprint(Sprint(
                      id: '',
                      projecId: '',
                      sprintNum: 0,
                      startingDate: DateTime.now(),
                      endDate: DateTime.now().add(const Duration(days: 14)),
                      status: '',
                      dailyScrum: [],
                      tasks: []));
                  Get.to(() => AddSprintScreen(
                        title: 'create sprint',
                      ));
                },
              ),
      ),
    );
  }
}
