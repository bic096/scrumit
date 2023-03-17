import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:scrumit/features/projects/domain/entities/project.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/projects/presentation/screens/home_screen.dart';
import 'package:scrumit/features/projects/presentation/screens/project_screen.dart';
import 'package:scrumit/features/projects/presentation/widgets/main_app_button_widget.dart';
import 'package:scrumit/features/sprints/presentation/controllers/sprint_controller.dart';
import 'package:scrumit/features/teams/presentation/controllers/team_controller.dart';

class ProjectListScreen extends StatelessWidget {
  final String title;
  ProjectListScreen({super.key, required this.title});

  final pCtrl = Get.find<ProjectController>();
  final authCtrl = Get.find<AuthController>();
  final tCtrl = Get.find<TeamController>();
  final sCtrl = Get.find<SprintController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //TODO: impelement
                authCtrl.logoutFun();
              },
              icon: const Icon(Icons.logout))
        ],
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
      body: Obx(
        (() => RefreshIndicator(
              onRefresh: () async {
                //TODO: must be edited
                await tCtrl.getUserTeamsListFun();
                pCtrl.listProjects(tCtrl.userTeamList);
              },
              child: Column(
                children: [
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Expanded(
                    child: pCtrl.requestStatus.value == RequestStatus.looding ||
                            authCtrl.requestStatus.value ==
                                RequestStatus.looding
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: pCtrl.projectList.length,
                            itemBuilder: (context, i) {
                              return MainAppButton(
                                width: 12,
                                label: pCtrl.projectList[i].projectName,
                                onPress: () async {
                                  pCtrl.currentProject = pCtrl.projectList[i];
                                  pCtrl.currentProjectId =
                                      pCtrl.currentProject.projectId!;
                                  tCtrl.teamId = pCtrl.projectList[i].teamId;
                                  await tCtrl.getTeamMemberListFun(
                                      teamId: tCtrl.teamId);

                                  Get.to(() => HomeScreen(
                                      title: pCtrl.currentProject.projectName));
                                  await sCtrl.getSprintListFun(
                                      projectId:
                                          pCtrl.currentProject.projectId!);
                                  // sCtrl.currentSprintId = sCtrl
                                  //     .sprintList[sCtrl.sprintList.indexWhere(
                                  //   (item) => item.status == 'current',
                                  // )]
                                  //     .id;
                                },
                              );
                            }),
                  ),
                ],
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO: implement add project Screen
          pCtrl.currentProject = Project(
              projectName: '',
              description: '',
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              ownerId: '',
              teamId: '');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProjectScreen(
                    title: 'create project',
                  )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddProjectScreen extends StatelessWidget {
  const AddProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
