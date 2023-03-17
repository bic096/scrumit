import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/auth/presentation/controllers/auth_controller.dart';

class RedirectingScreen extends StatelessWidget {
  RedirectingScreen({super.key});
  final authCtrl = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
