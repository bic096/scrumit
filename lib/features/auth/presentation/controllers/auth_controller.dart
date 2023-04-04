import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:scrumit/core/presentaion/landing_page.dart';
import 'package:scrumit/core/usecases/usercase.dart';

import 'package:scrumit/features/auth/domain/entities/user.dart';
import 'package:scrumit/features/auth/domain/usecases/auth_usecases.dart';
import 'package:scrumit/features/auth/presentation/screens/auth_screen.dart';
import 'package:scrumit/features/meetings/presentaion/controller/meeting_controller.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/projects/presentation/screens/project_list_screen.dart';
import 'package:scrumit/features/sprints/presentation/controllers/sprint_controller.dart';
import 'package:scrumit/features/teams/presentation/controllers/team_controller.dart';

import '../../../../injection_container.dart';

class AuthController extends GetxController {
  final Login login;
  final Signup signup;
  final GetAccount getAccount;
  final Logout logout;
  AuthController(
      {required this.login,
      required this.signup,
      required this.getAccount,
      required this.logout});

  Rx<RequestStatus> requestStatus = RequestStatus.idel.obs;
  final pCtrl = Get.find<ProjectController>();
  final tmCtrl = Get.find<TeamController>();
  // ignore: prefer_final_fields
  RxString _currentUserId = ''.obs;
  @override
  void onInit() async {
    await getAccountFun();
    super.onInit();
  }

  Future<String?> loginFun(String email, String password) async {
    requestStatus(RequestStatus.looding);

    final loginORfail =
        await login(params: Params(email: email, password: password));

    User? rr;
    loginORfail.fold((l) => null, (r) => rr = r);
    if (loginORfail.isLeft()) {
      requestStatus(RequestStatus.faild);
      debugPrint(loginORfail.toString());
      return 'email or password is wrong';
    } else {
      requestStatus(RequestStatus.success);
      debugPrint(loginORfail.toString());
      currentUserId = rr!.userId;
      // pCtrl.listProjects(currentUserId);
      await tmCtrl.getUserTeamsListFun();
      pCtrl.listProjects(tmCtrl.userTeamList);
      return null;
    }
  }

  Future<void> getAccountFun() async {
    requestStatus(RequestStatus.looding);
    final accountORfail = await getAccount(params: NoParams());
    accountORfail.fold((l) {
      requestStatus(RequestStatus.faild);
      Get.offAll(() => AuthScreen());
      debugPrint(l.toString());
    }, (r) async {
      requestStatus(RequestStatus.success);
      Get.offAll(() => ProjectListScreen(title: 'Project List'));
      debugPrint(r.toString());
      currentUserId = r.userId;
      await tmCtrl.getUserTeamsListFun();
      pCtrl.listProjects(tmCtrl.userTeamList);
      // pCtrl.listProjects(currentUserId);
    });
  }

  Future<String?> signupFun(
      {String? name, required String email, required String password}) async {
    requestStatus(RequestStatus.looding);
    final signupORfail = await signup(
        params: Params(name: name, email: email, password: password));
    User? rr;

    signupORfail.fold((l) => null, (r) => rr = r);
    if (signupORfail.isLeft()) {
      requestStatus(RequestStatus.faild);
      return 'Something went wrong';
    }
    requestStatus(RequestStatus.success);
    currentUserId = rr!.userId;
    // pCtrl.listProjects(currentUserId);
    await tmCtrl.getUserTeamsListFun();
    pCtrl.listProjects(tmCtrl.userTeamList);
    return null;
  }

  Future<void> logoutFun() async {
    requestStatus(RequestStatus.looding);
    final logoutORfail = await logout();

    logoutORfail.fold((l) {
      requestStatus(RequestStatus.faild);
    }, (r) async {
      requestStatus(RequestStatus.success);
      //clear the old project list and off to login page
      // Get.delete<ProjectController>();
      // Get.delete<MeetingController>();
      // Get.delete<SprintController>();
      // Get.delete<TeamController>();
      pCtrl.projectList([]);
      Get.off(() => AuthScreen());
    });
  }

  set currentUserId(String id) => _currentUserId(id);
  String get currentUserId => _currentUserId.value;
}
