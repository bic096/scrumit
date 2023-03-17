import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/meetings/presentaion/controller/meeting_controller.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});
  final mCtrl = Get.find<MeetingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: DyteMeeting(
            roomName: mCtrl.roomName,
            authToken: mCtrl.authToken,
            onInit: (DyteMeetingHandler meeting) async {}),
      ),
    );
  }
}
