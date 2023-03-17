import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/auth/presentation/controllers/auth_controller.dart';
import 'package:scrumit/features/projects/presentation/screens/project_list_screen.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final authCtrl = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'SCRUMIT',
      onLogin: (data) async {
        debugPrint(data.toString());
        return await authCtrl.loginFun(data.name, data.password);
      },
      onRecoverPassword: (data) {
        return null;
      },
      onSignup: (p0) async {
        return await authCtrl.signupFun(
            email: p0.name!, password: p0.password!);
      },
      theme: LoginTheme(primaryColor: ThemeData.dark().primaryColor),
      onSubmitAnimationCompleted: () =>
          Get.off(() => ProjectListScreen(title: 'Project List Page')),
    );
  }
}
