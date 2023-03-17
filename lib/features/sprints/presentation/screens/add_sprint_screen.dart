import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/core/presentaion/text_style.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/projects/presentation/widgets/main_app_button_widget.dart';
import 'package:scrumit/features/sprints/presentation/controllers/sprint_controller.dart';

class AddSprintScreen extends StatelessWidget {
  AddSprintScreen({super.key, this.title});

  final String? title;

  final pCtrl = Get.find<ProjectController>();
  final sCtrl = Get.find<SprintController>();
  //final aCtrl = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        title: title == null ? null : Text(title!),
      ),
      body: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'start date',
                  style: CustomTextStyle.buttonTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () async {
                      sCtrl.sprintCopyWith(
                          starDate: await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2026)));
                    },
                    child: Text(
                        sCtrl.sprint.value.startingDate.toIso8601String())),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'end date',
                  style: CustomTextStyle.buttonTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () async {
                      sCtrl.sprintCopyWith(
                          endDate: await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.now().add(const Duration(days: 14)),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2026)));
                    },
                    child: Text(sCtrl.sprint.value.endDate.toIso8601String()))
              ]),
              MainAppButton(
                label: 'Submit',
                onPress: () async {
                  if (title == 'create sprint') {
                    sCtrl.sprintCopyWith(
                        status: 'current',
                        sprintNum: sCtrl.sprintList.length + 1,
                        projectId: pCtrl.currentProject.projectId);
                    await sCtrl.createSprintFun(
                        projectId: pCtrl.currentProjectId,
                        sprint: sCtrl.sprint.value);
                  }

                  // if (title == pCtrl.currentProject.projectName) {
                  //   await pCtrl.(
                  //       pCtrl.currentProjec.projectName                     pCtrl.currentProject.projectName
                  // }
                  //

                  Get.back();

                  sCtrl.getSprintListFun(projectId: pCtrl.currentProjectId);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
