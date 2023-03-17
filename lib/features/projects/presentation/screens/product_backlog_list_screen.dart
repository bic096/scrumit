import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/features/projects/domain/entities/product_backlog.dart';
import 'package:scrumit/features/projects/presentation/controllers/product_backlog_controller.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/projects/presentation/screens/product_backlog_screen.dart';

class ProductBacklogListScreen extends StatelessWidget {
  ProductBacklogListScreen({key, this.title}) : super(key: key);
  final String? title;
  final pblCtrl = Get.find<ProductBacklogController>();
  final pCtrl = Get.find<ProjectController>();

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
      body: SizedBox(
        child: Obx(
          () => pblCtrl.requestStatus.value == RequestStatus.looding
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
                      RefreshIndicator(
                        onRefresh: () async {
                          pblCtrl.listProductBacklogs(pCtrl.currentProjectId);
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height -
                              kToolbarHeight,
                          width: MediaQuery.of(context).size.width,
                          child: RefreshIndicator(
                            onRefresh: () async {
                              pblCtrl
                                  .listProductBacklogs(pCtrl.currentProjectId);
                            },
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    pblCtrl.productBacklogList.length + 1,
                                itemBuilder: ((context, i) => i ==
                                        pblCtrl.productBacklogList.length
                                    ? const SizedBox(
                                        height: 60,
                                      )
                                    : Card(
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
                                                    pblCtrl.productBacklog(pblCtrl
                                                        .productBacklogList[i]);
                                                    Get.to(() =>
                                                        ProductBacklogScreen(
                                                            title: pblCtrl
                                                                .productBacklog
                                                                .value
                                                                .name));
                                                  },
                                                  // isThreeLine: true,

                                                  title: Text(
                                                    pblCtrl
                                                                .productBacklogList[
                                                                    i]
                                                                .name
                                                                .length >
                                                            21
                                                        ? pblCtrl
                                                            .productBacklogList[
                                                                i]
                                                            .name
                                                            .replaceRange(21,
                                                                null, ' ...')
                                                        : pblCtrl
                                                            .productBacklogList[
                                                                i]
                                                            .name,
                                                    textScaleFactor: 1.1,
                                                  ),
                                                  leading: Text(pblCtrl
                                                      .productBacklogList[i]
                                                      .priority),
                                                  subtitle: Text(
                                                    pblCtrl
                                                                .productBacklogList[
                                                                    i]
                                                                .description
                                                                .length >
                                                            70
                                                        ? pblCtrl
                                                            .productBacklogList[
                                                                i]
                                                            .description
                                                            .replaceRange(70,
                                                                null, ' ...')
                                                        : pblCtrl
                                                            .productBacklogList[
                                                                i]
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
                                                      var release = pblCtrl
                                                          .productBacklogList[i]
                                                          .copyWith(
                                                              type: 'release');
                                                      await pblCtrl
                                                          .updateProductBacklogFun(
                                                              release,
                                                              release.id);
                                                      pblCtrl.listProductBacklogs(
                                                          pCtrl
                                                              .currentProjectId);
                                                    },
                                                    child: const Center(
                                                        heightFactor: 3,
                                                        child:
                                                            Text('To Release')),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ))),
                          ),
                        ),
                      )
                      // ListView.separated(
                      //   shrinkWrap: true,
                      //   itemCount: pblCtrl.productBacklogList.length,
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
                      //                   Text(pblCtrl.productBacklogList[i].name),
                      //                   Spacer(),
                      //                   Text(pblCtrl.productBacklogList[i].priority
                      //                       .toString())
                      //                 ],
                      //               ),
                      //               Divider(
                      //                 color: Colors.white,
                      //                 thickness: .5,
                      //               ),
                      //               Text(pblCtrl.productBacklogList[i].description)
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
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            pblCtrl.productBacklog(ProductBacklog(
                name: '',
                description: '',
                priority: '',
                createdAt: DateTime.now(),
                id: '',
                type: '',
                projectId: pCtrl.currentProjectId));
            Get.to(() => ProductBacklogScreen(
                  title: 'add User Story',
                ));
          }),
    );
  }
}
