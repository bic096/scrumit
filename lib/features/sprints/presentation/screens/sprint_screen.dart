import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/sprints/presentation/controllers/sprint_controller.dart';
import 'package:scrumit/features/sprints/presentation/screens/task_screen.dart';

class SprintScreen extends StatelessWidget {
  SprintScreen({super.key});
  final sCtrl = Get.find<SprintController>();
  final pCtrl = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                const Size(double.infinity, kBottomNavigationBarHeight),
            child: Obx(
              () => AppBar(
                actions: [
                  sCtrl.currentSprint.status == 'current'
                      ? IconButton(
                          onPressed: (() {
                            sCtrl.sprintEditable(!sCtrl.sprintEditable.value);
                          }),
                          icon: const Icon(Icons.edit))
                      : Container(),
                  IconButton(
                      onPressed: (() async {
                        if (sCtrl.currentSprint.sprintNum ==
                            sCtrl.sprintList.length) {
                          sCtrl.currentSprintCopyWith(
                              status: sCtrl.currentSprint.status == 'current'
                                  ? 'done'
                                  : 'current');
                          await sCtrl.updateSprintFun(
                              sprintId: sCtrl.currentSprint.id,
                              sprint: sCtrl.currentSprint);
                          await sCtrl.getSprintListFun(
                              projectId: pCtrl.currentProject.projectId!);
                        }
                      }),
                      icon: Icon(
                        Icons.toggle_off,
                        color: sCtrl.currentSprint.status == 'current'
                            ? Colors.green
                            : Colors.grey,
                      ))
                ],
                title: const Text('Sprint'),
              ),
            )),
        body: Obx(() {
          return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                sCtrl.requestStatus.value == RequestStatus.looding
                    ? const Text('looding')
                    : sCtrl.requestStatus.value == RequestStatus.faild
                        ? const Text('faild')
                        : sCtrl.requestStatus.value == RequestStatus.idel
                            ? const Text('Idel Status')
                            : Card(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 10, 10),
                                  height:
                                      MediaQuery.of(context).size.height * .20,
                                  width: MediaQuery.of(context).size.width * 40,
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text(
                                          'Number',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          sCtrl.currentSprint.sprintNum
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text(
                                          'Started',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          sCtrl.currentSprint.startingDate
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text(
                                          'End',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          sCtrl.currentSprint.endDate
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ]),
                                ),
                              ),
                // sCtrl.currentSprint.sprintPlanning == null
                //     ? Container()
                //     :
                Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Planning '),
                          const SizedBox(
                            height: 10,
                          ),
                          sCtrl.sprintEditable.value == false
                              ? ExpandableText(
                                  sCtrl.currentSprint.sprintPlanning == null
                                      ? 'click to add planning'
                                      : sCtrl.currentSprint.sprintPlanning!
                                              .isEmpty
                                          ? 'click to add planning'
                                          : sCtrl.currentSprint.sprintPlanning!,
                                  expandText: 'more...',
                                  expandOnTextTap: true,
                                  collapseOnTextTap: true,
                                  linkColor: Colors.grey,
                                )
                              : TextFormField(
                                  initialValue:
                                      sCtrl.currentSprint.sprintPlanning,
                                  onFieldSubmitted: (value) {
                                    sCtrl.currentSprintCopyWith(
                                        sprintPlaning: value);
                                    sCtrl.updateSprintFun(
                                        sprintId: sCtrl.currentSprintId,
                                        sprint: sCtrl.currentSprint);
                                  },
                                )
                        ]),
                  ),
                ),
                /////////////////////////////
                //////
                //////
                /////////////////////////////
                // sCtrl.currentSprint.sprintReview == null
                //     ? Container()
                //     :
                Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Review '),
                          const SizedBox(
                            height: 10,
                          ),
                          sCtrl.sprintEditable.value == false
                              ? ExpandableText(
                                  sCtrl.currentSprint.sprintReview ??
                                      'click to add review',
                                  expandText: 'more...',
                                  expandOnTextTap: true,
                                  collapseOnTextTap: true,
                                  linkColor: Colors.grey,
                                )
                              : TextFormField(
                                  initialValue:
                                      sCtrl.currentSprint.sprintReview,
                                  onFieldSubmitted: (value) {
                                    sCtrl.currentSprintCopyWith(
                                        sprintReview: value);
                                    sCtrl.updateSprintFun(
                                        sprintId: sCtrl.currentSprintId,
                                        sprint: sCtrl.currentSprint);
                                  },
                                )
                        ]),
                  ),
                ),
                /////////////////////////////////
                ///////
                ///////
                ///////
                /////////////////////////////////
                // sCtrl.currentSprint.retrospective == null
                //     ? Container()
                //     :
                Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Planning '),
                          const SizedBox(
                            height: 10,
                          ),
                          sCtrl.sprintEditable.value == false
                              ? ExpandableText(
                                  sCtrl.currentSprint.retrospective ??
                                      'click add retrospective',
                                  expandText: 'more...',
                                  expandOnTextTap: true,
                                  collapseOnTextTap: true,
                                  linkColor: Colors.grey,
                                )
                              : TextFormField(
                                  initialValue:
                                      sCtrl.currentSprint.retrospective,
                                  onFieldSubmitted: (value) {
                                    sCtrl.currentSprintCopyWith(
                                        retrospective: value);
                                    sCtrl.updateSprintFun(
                                        sprintId: sCtrl.currentSprintId,
                                        sprint: sCtrl.currentSprint);
                                  },
                                )
                        ]),
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //     padding: EdgeInsets.symmetric(horizontal: 20),
                //     child: Text('Tasks :')),
                /////////////////////////

                ///////////////////////
                TaskScreen()
              ]));
        }));
  }
}
