import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/projects/presentation/controllers/release_backlog_controller.dart';
import 'package:scrumit/features/projects/presentation/screens/release_backlog_screen.dart';
import 'package:scrumit/features/sprints/presentation/controllers/sprint_controller.dart';

class ReleaseBacklogListScreen extends StatelessWidget {
  ReleaseBacklogListScreen({key, this.title}) : super(key: key);

  final String? title;
  final rblCtrl = Get.find<ReleaseBacklogController>();
  final pCtrl = Get.find<ProjectController>();
  final sCtrl = Get.find<SprintController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title == null ? null : Text(title!),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () => rblCtrl.requestStatus.value == RequestStatus.looding
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),

                    // DynamicDataTable(rblCtrl: rblCtrl)
                    SizedBox(
                      height:
                          MediaQuery.of(context).size.height - kToolbarHeight,
                      width: MediaQuery.of(context).size.width,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          rblCtrl.listReleaseBacklogs(pCtrl.currentProjectId);
                        },
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: rblCtrl.releaseBacklogList.length + 1,
                            itemBuilder: ((context, i) => i ==
                                    rblCtrl.releaseBacklogList.length
                                ? const SizedBox(
                                    height: 60,
                                  )
                                : Card(
                                    // color: Colors.transparent,
                                    elevation: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: ListTile(
                                              onTap: () {
                                                rblCtrl.releaseBacklog(rblCtrl
                                                    .releaseBacklogList[i]);
                                                Get.to(() =>
                                                    ReleaseBacklogScreen(
                                                        title: rblCtrl
                                                            .releaseBacklog
                                                            .value
                                                            .name));
                                              },
                                              // isThreeLine: true,

                                              title: Text(
                                                rblCtrl.releaseBacklogList[i]
                                                            .name.length >
                                                        21
                                                    ? rblCtrl
                                                        .releaseBacklogList[i]
                                                        .name
                                                        .replaceRange(
                                                            21, null, ' ...')
                                                    : rblCtrl
                                                        .releaseBacklogList[i]
                                                        .name,
                                                textScaleFactor: 1.1,
                                              ),
                                              leading: Text(rblCtrl
                                                  .releaseBacklogList[i]
                                                  .priority),
                                              subtitle: Text(
                                                rblCtrl
                                                            .releaseBacklogList[
                                                                i]
                                                            .description
                                                            .length >
                                                        70
                                                    ? rblCtrl
                                                        .releaseBacklogList[i]
                                                        .description
                                                        .replaceRange(
                                                            70, null, ' ...')
                                                    : rblCtrl
                                                        .releaseBacklogList[i]
                                                        .description,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .hintColor),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () async {
                                                  var release = rblCtrl
                                                      .releaseBacklogList[i]
                                                      .copyWith(
                                                          type: 'task',
                                                          sprintId: sCtrl
                                                              .currentSprintId);
                                                  await rblCtrl
                                                      .updateReleaseBacklogFun(
                                                          release, release.id);
                                                  rblCtrl.listReleaseBacklogs(
                                                      pCtrl.currentProjectId);
                                                },
                                                child: const Center(
                                                    heightFactor: 3,
                                                    child: Text('To Task')),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ))),
                      ),
                    )
                    // ListView.separated(
                    //   shrinkWrap: true,
                    //   itemCount: rblCtrl.releaseBacklogList.length,
                    //   itemBuilder: (c, i) {
                    //     return Card(
                    //       child: Padding(
                    //         padding:
                    //             EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    //         child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   Text(rblCtrl.releaseBacklogList[i].name),
                    //                   Spacer(),
                    //                   Text(rblCtrl.releaseBacklogList[i].priority
                    //                       .toString())
                    //                 ],
                    //               ),
                    //               Divider(
                    //                 color: Colors.white,
                    //                 thickness: .5,
                    //               ),
                    //               Text(rblCtrl.releaseBacklogList[i].description)
                    //             ]),
                    //       ),
                    //     );
                    //   },
                    //   separatorBuilder: (context, index) => Divider(),
                    // )
                  ]),
                ),
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: const Icon(Icons.add),
      //     onPressed: () {
      //       rblCtrl.releaseBacklog(ReleaseBacklog(
      //           name: '',
      //           description: '',
      //           priority: '',
      //           createdAt: DateTime.now(),
      //           id: '',
      //           type: '',
      //           projectId: pCtrl.currentProjectId));
      //       Get.to(() => ReleaseBacklogScreen(
      //             title: 'add release backlog',
      //           ));
      //     }),
    );
  }
}
