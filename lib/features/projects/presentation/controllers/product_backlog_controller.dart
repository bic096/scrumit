import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/features/projects/domain/entities/product_backlog.dart';
import 'package:scrumit/features/projects/domain/usecases/project_usecases.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';

class ProductBacklogController extends GetxController {
  final GetProductBacklog getProductBacklog;
  final GetProductBacklogList getProductBacklogList;
  final CreateProductBacklog createProductBacklog;
  final UpdateProductBacklog updateProductBacklog;
  ProductBacklogController(
      {required this.createProductBacklog,
      required this.getProductBacklog,
      required this.getProductBacklogList,
      required this.updateProductBacklog});

  final pCtrl = Get.find<ProjectController>();

  Rx<ProductBacklog> productBacklog = ProductBacklog(
          id: '',
          createdAt: DateTime.now(),
          projectId: '',
          name: '',
          description: '',
          type: 'story',
          priority: '')
      .obs;

  RxList<ProductBacklog> productBacklogList = <ProductBacklog>[].obs;
  Rx<RequestStatus> requestStatus = RequestStatus.idel.obs;

  void productCopyWith(
      {String? name, String? description, String? priority, String? type}) {
    productBacklog(productBacklog.value.copyWith(
        name: name, description: description, priority: priority, type: type));
  }

  @override
  void onInit() {
    listProductBacklogs(pCtrl.currentProjectId);

    super.onInit();
  }

  void listProductBacklogs(String projectID) async {
    requestStatus(RequestStatus.looding);
    final failureOrList =
        await getProductBacklogList(params: Params(projectId: projectID));
    failureOrList.fold((Failure l) {
      requestStatus(RequestStatus.faild);
      debugPrint(l.toString());
    }, (List<ProductBacklog> r) {
      requestStatus(RequestStatus.success);
      debugPrint(r.toString());
      productBacklogList(r);
    });
  }

  void productBacklogDetails(String productBacklogId) async {
    final failureOrProject = await getProductBacklog(
        params: Params(productBacklogId: productBacklogId));

    failureOrProject.fold((l) {
      requestStatus(RequestStatus.faild);
    }, (ProductBacklog r) {
      requestStatus(RequestStatus.success);
      debugPrint(r.toString());
      productBacklog(r);
    });
  }

//TODO: add project id param
  Future<void> addProductBacklog(ProductBacklog productBacklog) async {
    final failureOrproject = await createProductBacklog(
        params: Params(productBacklog: productBacklog));
    failureOrproject.fold((l) {
      requestStatus(RequestStatus.faild);
    }, (r) {
      requestStatus(RequestStatus.success);
      this.productBacklog(r);
    });
  }

  Future<void> updateProductBacklogFun(
      ProductBacklog productBacklog, String id) async {
    requestStatus(RequestStatus.looding);
    final failureOrSuccess = await updateProductBacklog(
        params: Params(productBacklog: productBacklog, productBacklogId: id));

    failureOrSuccess.fold((l) {
      requestStatus(RequestStatus.faild);
    }, (r) {
      requestStatus(RequestStatus.success);
      this.productBacklog(r);
    });
  }
} 


// var tableHeading = <DataColumn>[
  //   DataColumn(label: Text('name')),
  //   DataColumn(label: Text('description')),
  //   DataColumn(label: Text('priority'), numeric: true),
  //   DataColumn(label: Text('name')),
  //   DataColumn(label: Text('description')),
  //   DataColumn(label: Text('priority'), numeric: true)
  // ];

  // var tableData = <DataRow>[];
  // void setTableData() {
  //   for (var element in productBacklogList) {
  //     tableData.add(DataRow(cells: <DataCell>[
  //       DataCell(Text(element.name)),
  //       DataCell(Text(element.description)),
  //       DataCell(Text(element.priority.toString())),
  //       DataCell(Text(element.name)),
  //       DataCell(Text(element.description)),
  //       DataCell(Text(element.priority.toString())),
  //     ]));
  //   }
  // }
// class DynamicDataTable extends StatelessWidget {
//   const DynamicDataTable({
//     Key? key,
//     required this.pblController,
//   }) : super(key: key);

//   final ProductBacklogController pblController;

//   @override
//   Widget build(BuildContext context) {
//     return DataTable(
//         border: TableBorder.all(
//             color: Colors.white30,
//             width: 0.4,
//             borderRadius: BorderRadius.horizontal()),
//         columns: pblController.tableHeading
//         //   <DataColumn>[
//         // DataColumn(label: Text('name')),
//         // DataColumn(label: Text('description')),
//         // DataColumn(label: Text('priority'), numeric: true),
//         // DataColumn(label: Text('name')),
//         // DataColumn(label: Text('description')),
//         // DataColumn(label: Text('priority'), numeric: true)
//         //
//         ,
//         rows: pblController.tableData
//         //  <DataRow>[
//         //   DataRow(cells: <DataCell>[
//         //     DataCell(Text(pblController.productBacklogList[0].name)),
//         //     DataCell(Text(pblController.productBacklogList[0].description)),
//         //     DataCell(
//         //         Text(pblController.productBacklogList[0].priority.toString())),
//         //     DataCell(Text(pblController.productBacklogList[0].name)),
//         //     DataCell(Text(pblController.productBacklogList[0].description)),
//         //     DataCell(
//         //         Text(pblController.productBacklogList[0].priority.toString())),
//         //   ]),
//         //   DataRow(cells: <DataCell>[
//         //     DataCell(Text(pblController.productBacklogList[1].name)),
//         //     DataCell(Text(pblController.productBacklogList[1].description)),
//         //     DataCell(
//         //         Text(pblController.productBacklogList[1].priority.toString())),
//         //     DataCell(Text(pblController.productBacklogList[1].name)),
//         //     DataCell(Text(pblController.productBacklogList[1].description)),
//         //     DataCell(
//         //         Text(pblController.productBacklogList[1].priority.toString())),
//         //   ]
//         //),
//         // ]
//         );
//   }
// }
