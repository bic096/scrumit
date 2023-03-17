import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/teams/presentation/controllers/team_controller.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tCtrl = Get.find<TeamController>();
    return SizedBox(
      // decoration: BoxDecoration(
      //     color: Theme.of(context).cardColor,
      //     borderRadius: BorderRadius.circular(5),
      //     border: Border.all()),
      height: 230,
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Text('Team'),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        tCtrl.onAddMemberClick();
                      },
                      icon: const Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () {
                        tCtrl.getTeamMemberListFun(teamId: tCtrl.teamId);
                      },
                      icon: const Icon(Icons.refresh_sharp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 1,
        ),
        const Divider(
          thickness: 1,
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 150,
          child: Obx(() => ListView.builder(
              // separatorBuilder: ((context, index) => Column(
              //       children: [
              //         Divider(),
              //       ],
              //     )),
              itemCount: tCtrl.teamMemberList.length,
              itemBuilder: ((context, index) => Card(
                    elevation: .5,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      margin: const EdgeInsets.only(bottom: 5),
                      // decoration: BoxDecoration(
                      //     // border: Border.all(color: Colors.white10)
                      //      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          height: 35,
                          child: ListTile(
                            title: Text(tCtrl.teamMemberList[index].userEmail),
                            trailing: tCtrl.teamMemberList[index].roles!
                                    .contains('owner')
                                ? const Text(
                                    'Scrum Master',
                                    style: TextStyle(color: Colors.greenAccent),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      tCtrl.deleteTeamMemberFun(
                                          teamId: tCtrl.teamId,
                                          membrShipId:
                                              tCtrl.teamMemberList[index].id);
                                    },
                                    icon: const Icon(Icons.cancel_sharp),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  )))),
        ),
      ]),
    );
  }
}
