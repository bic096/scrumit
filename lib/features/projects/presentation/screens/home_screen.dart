import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/meetings/presentaion/controller/meeting_controller.dart';
import 'package:scrumit/features/meetings/presentaion/screens/meeting_screen.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/projects/presentation/screens/release_backlog_list_screen.dart';
import 'package:scrumit/features/projects/presentation/screens/product_backlog_list_screen.dart';
import 'package:scrumit/features/projects/presentation/widgets/main_app_button_widget.dart';
import 'package:scrumit/features/sprints/presentation/controllers/sprint_controller.dart';
import 'package:scrumit/features/sprints/presentation/screens/sprint_list_screen.dart';
import 'package:scrumit/features/teams/presentation/screens/team_screen.dart';
import 'package:scrumit/utils/size_helper.dart' as size;

import '../../../auth/presentation/controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.title,
  });

  final String title;
  final pCtrl = Get.find<ProjectController>();
  final sCtrl = Get.find<SprintController>();
  final mCtrl = Get.find<MeetingController>();
  final authCtrl = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(title),
      ),
      body: Obx((() => SingleChildScrollView(
            child: Column(
              children: [
                pCtrl.requestStatus.value == RequestStatus.looding
                    ? const Text('looding')
                    : pCtrl.requestStatus.value == RequestStatus.faild
                        ? const Text('faild')
                        : pCtrl.requestStatus.value == RequestStatus.idel
                            ? const Text('Idel Status')
                            : Card(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 10, 10),
                                  height: size.displayHeight(context) * .25,
                                  width: size.displayWidth(context) * 40,
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text(
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          pCtrl.currentProject.projectName,
                                          style: const TextStyle(
                                              // fontSize: 18,
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
                                          pCtrl.currentProject.startDate
                                              .toString(),
                                          style: const TextStyle(
                                              // fontSize: 15,
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
                                          pCtrl.currentProject.endDate
                                              .toString(),
                                          style: const TextStyle(
                                              // fontSize: 15,
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
                                          'Description',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          pCtrl.currentProject.description
                                                      .length >
                                                  21
                                              ? pCtrl.currentProject.description
                                                  .replaceRange(
                                                      21, null, ' ...')
                                              : pCtrl
                                                  .currentProject.description,
                                          style: const TextStyle(
                                              // fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ]),
                                ),
                              ),
                const SizedBox(
                  height: 20,
                ),
                // const MainAppButton(
                //   label: 'Team',
                // ),
                const TeamScreen(),
                const SizedBox(
                  height: 20,
                ),
                MainAppButton(
                  width: double.infinity,
                  onPress: () {
                    sCtrl.getSprintListFun(
                        projectId: pCtrl.currentProject.projectId!);
                    Get.to(() => SprintListScreen());
                  },
                  label: 'Sprints',
                ),
                MainAppButton(
                  width: double.infinity,
                  label: 'user Stories',
                  onPress: () => Get.to(() => ProductBacklogListScreen(
                        title: 'User Stories List',
                      )),
                ),

                MainAppButton(
                  width: double.infinity,
                  onPress: () => Get.to(() => ReleaseBacklogListScreen(
                        title: 'Release Backlog List',
                      )),
                  label: 'Release',
                ),
                MainAppButton(
                  width: double.infinity,
                  label: 'meeting',
                  onPress: () async {
                    var v = await mCtrl.joinMeetingFun(
                        projectId: pCtrl.currentProject.projectId!,
                        userId: authCtrl.currentUserId);
                    if (v == true) {
                      Get.to(() => MeetingScreen());
                    }
                  },
                )
              ],
            ),
          ))),
    );
  }
}
