import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/core/usecases/usercase.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/teams/domain/entities/team.dart';
import 'package:scrumit/features/teams/domain/usecases/teams_usecases.dart';

class TeamController extends GetxController {
  final GetTeamMemberList getTeamMemberList;
  final AddTeamMember addTeamMember;
  final DeleteTeamMember deleteTeamMember;
  final GetUSerTeamsList getUSerTeamsList;
  TeamController(this.addTeamMember, this.deleteTeamMember,
      this.getTeamMemberList, this.getUSerTeamsList);
  // @override
  // void onInit() {
  //   getTeamMemberListFun(teamId: teamId);
  //   super.onInit();
  // }
  late List<String> userTeamList = [];
  late String teamId;
  var requestStatus = RequestStatus.idel.obs;
  RxList<MemberShip> teamMemberList = <MemberShip>[].obs;

  Future<void> getUserTeamsListFun() async {
    userTeamList = [];
    final listorfail = await getUSerTeamsList(params: NoParams());
    listorfail.fold((l) => userTeamList = [], (r) {
      for (var t in r) {
        userTeamList.add(t.id);
      }
    });
  }

  Future<void> getTeamMemberListFun({required String teamId}) async {
    requestStatus(RequestStatus.looding);
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    final listORfail = await getTeamMemberList(params: Params(teamId: teamId));

    listORfail.fold((l) {
      requestStatus(RequestStatus.faild);
      Get.dialog(const Center(
        child: Text('FAild'),
      ));
      Get.back();
    }, (r) {
      teamMemberList(r);
      Get.back();
      if (Get.isDialogOpen != null && Get.isDialogOpen == true) {
        Get.back();
        debugPrint(r.toString());
        requestStatus(RequestStatus.success);
      }
    });
  }

  Future<void> addTeamMemberFun(
      {required String teamId, required String userEmail}) async {
    requestStatus(RequestStatus.looding);
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    final memberORfail = await addTeamMember(
        params: Params(teamId: teamId, userEmail: userEmail));

    memberORfail.fold((l) {
      requestStatus(RequestStatus.faild);
      Get.dialog(const Center(
        child: Text('FAild'),
      ));
      Get.back();
    }, (r) {
      requestStatus(RequestStatus.success);

      getTeamMemberListFun(teamId: teamId);
      Get.back();
      if (Get.isDialogOpen != null) {
        if (Get.isDialogOpen!) Get.back();
      }
    });
  }

  Future<void> deleteTeamMemberFun(
      {required String teamId, required String membrShipId}) async {
    requestStatus(RequestStatus.looding);
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    final deleteORfail = await deleteTeamMember(
        params: Params(teamId: teamId, memberShipId: membrShipId));

    deleteORfail.fold((l) {
      requestStatus(RequestStatus.faild);
      Get.dialog(const Center(
        child: Text('FAild'),
      ));
    }, (r) {
      getTeamMemberListFun(teamId: teamId);
    });
  }

  void onAddMemberClick() {
    isItvaliedEmail(false);
    Get.dialog(Center(child: AddTeamMemberWidget()));
  }

  RxBool isItvaliedEmail = false.obs;
  void isEmailValid(String? txt) {
    if (txt != null) {
      if (EmailValidator.validate(txt) == true) {
        isItvaliedEmail(true);
      }
      if (EmailValidator.validate(txt) == false) {
        isItvaliedEmail(false);
      }
    }
  }
}

class AddTeamMemberWidget extends StatelessWidget {
  AddTeamMemberWidget({super.key});
  final tCtrl = Get.find<TeamController>();
  @override
  Widget build(BuildContext context) {
    final emailCotroller = TextEditingController();
    return Card(
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a valid Email Adress'),
                controller: emailCotroller,
                onChanged: (value) {
                  tCtrl.isEmailValid(value);
                },
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(tCtrl.isItvaliedEmail.value == true
                    ? "Email is valid"
                    : "Enter a valid email please"),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Obx(
              () => MaterialButton(
                  onPressed: tCtrl.isItvaliedEmail.isTrue
                      ? () {
                          tCtrl.addTeamMemberFun(
                              teamId: tCtrl.teamId,
                              userEmail: emailCotroller.text);
                        }
                      : null,
                  child: const Text('submit')),
            )
          ],
        ),
      ),
    );
  }
}
