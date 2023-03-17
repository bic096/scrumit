import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/sprints/presentation/controllers/task_controller.dart';
import 'package:scrumit/features/sprints/presentation/widgets/task_status_widget.dart';
import 'package:scrumit/features/sprints/presentation/widgets/task_users_widget.dart';
import 'package:scrumit/features/teams/domain/entities/team.dart';
import 'package:scrumit/features/teams/presentation/controllers/team_controller.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});
  final tkCtrl = Get.find<TaskController>();
  final tmCtrl = Get.find<TeamController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Obx(
        (() => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: tkCtrl.taskList.isEmpty
                  ? Container()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 1.2,
                      child: Column(
                        children: [
                          Card(
                            elevation: 0,
                            child: Container(
                              // width: MediaQuery.of(context).size.width * 1.1,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: const [
                                  Expanded(
                                    flex: 6,
                                    child: Text('description'),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                  ),
                                  Expanded(flex: 2, child: Text('status')),
                                  VerticalDivider(
                                    thickness: 2,
                                  ),
                                  Expanded(flex: 3, child: Text('user'))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 250,
                            width: MediaQuery.of(context).size.width * 1.2,
                            child: ListView.builder(
                                itemCount: tkCtrl.taskList.length + 1,
                                itemBuilder: ((context, index) {
                                  List<String> usersEmailsList = [];
                                  for (MemberShip element
                                      in tmCtrl.teamMemberList) {
                                    if (index != tkCtrl.taskList.length) {
                                      if (tkCtrl.taskList[index].usersIds
                                          .contains(element.userId)) {
                                        usersEmailsList.add(element.userEmail);
                                      }
                                    }
                                  }
                                  if (index == tkCtrl.taskList.length) {
                                    return const SizedBox(
                                      height: 30,
                                    );
                                  }
                                  return Card(
                                    elevation: .5,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          1.1,
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 6,
                                              child: Text(tkCtrl.taskList[index]
                                                          .description ==
                                                      null
                                                  ? ''
                                                  : tkCtrl
                                                              .taskList[index]
                                                              .description!
                                                              .length <
                                                          70
                                                      ? tkCtrl.taskList[index]
                                                          .description!
                                                      : tkCtrl.taskList[index]
                                                          .description!
                                                          .replaceRange(40,
                                                              null, '...'))),
                                          const VerticalDivider(
                                            thickness: 2,
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: InkWell(
                                                onTap: () {
                                                  tkCtrl.task(
                                                      tkCtrl.taskList[index]);
                                                  Get.bottomSheet(
                                                      TaskStatusWidget(
                                                          taskIndex: index));
                                                },
                                                child: Text(tkCtrl
                                                    .taskList[index].status),
                                              )),
                                          const VerticalDivider(
                                            thickness: 2,
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: InkWell(
                                                onTap: () {
                                                  tkCtrl.task(
                                                      tkCtrl.taskList[index]);
                                                  Get.bottomSheet(
                                                      TaskUsersWidget(
                                                          taskIndex: index));
                                                },
                                                child: Text(usersEmailsList
                                                    .toString()
                                                    .replaceAll(
                                                        RegExp(r'[\,[\]]'),
                                                        '')),
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ),
                        ],
                      ),
                    ),
            )),
      ),
    );
  }
}
