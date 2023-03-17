import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/core/presentaion/editable_text_widget.dart' as editable;
import 'package:scrumit/core/presentaion/text_style.dart';
import 'package:scrumit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:scrumit/features/projects/presentation/widgets/main_app_button_widget.dart';
import 'package:scrumit/features/teams/presentation/controllers/team_controller.dart';

import '../controllers/project_controller.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen({super.key, this.title});

  final String? title;

  final pCtrl = Get.find<ProjectController>();
  final tmCtrl = Get.find<TeamController>();
  final aCtrl = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

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
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Name',
                          style: CustomTextStyle.buttonTextStyle),
                      const SizedBox(
                        height: 10,
                      ),
                      editable.EditableText(
                        onChanged: (value) {
                          pCtrl.projectCopyWith(name: value);
                          // debugPrint(pCtrl.currentProject.projectNamering());
                        },
                        formGlobalKey: _formKey,
                        onsubmit: (String value) {
                          pCtrl.projectCopyWith(name: value);
                          //     debugPrint(pCtrl.currentProject.projectNamering());
                        },
                        onEditingComplete: () {
                          _formKey.currentState?.save();
                        },
                        onSaved: (var newValue) {
                          pCtrl.projectCopyWith(name: newValue);
                          // debugPrint(pCtrl.currentProject.projectNamering());
                        },
                        data: pCtrl.currentProject.projectName,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'discription',
                        style: CustomTextStyle.buttonTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      editable.EditableText(
                        onChanged: (value) {
                          pCtrl.projectCopyWith(description: value);
                          // debugPrint(pCtrl.currentProject.());
                        },
                        formGlobalKey: _formKey,
                        onsubmit: (value) {
                          pCtrl.projectCopyWith(description: value);
                          //debugPrint(pCtrl.currentProject.projectNamering());
                        },
                        onSaved: (var newValue) {
                          pCtrl.projectCopyWith(description: newValue);
                          //  debugPrint(pCtrl.currentProject.projectNamering());
                        },
                        data: pCtrl.currentProject.description,
                        onEditingComplete: () {
                          _formKey.currentState?.save();
                        },
                      ),
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
                            pCtrl.projectCopyWith(
                                startDate: await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2026)));
                          },
                          child: Text(pCtrl.currentProject.startDate
                              .toIso8601String())),
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
                            pCtrl.projectCopyWith(
                                endDate: await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2026)));
                          },
                          child: Text(
                              pCtrl.currentProject.endDate.toIso8601String()))
                    ]),
              ),
              MainAppButton(
                label: 'Submit',
                onPress: () async {
                  _formKey.currentState?.save();
                  debugPrint(_formKey.currentState.toString());
                  if (title == 'create project') {
                    pCtrl.projectCopyWith(ownerId: aCtrl.currentUserId);
                    await pCtrl.addProject(pCtrl.currentProject);
                    await tmCtrl.getUserTeamsListFun();
                  }

                  // if (title == pCtrl.currentProject.projectName) {
                  //   await pCtrl.(
                  //       pCtrl.currentProjec.projectName                     pCtrl.currentProject.projectName
                  // }
                  //

                  Get.back();

                  pCtrl.listProjects(tmCtrl.userTeamList);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
