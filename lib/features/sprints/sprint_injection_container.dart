import 'package:get/get.dart';
import 'package:scrumit/features/sprints/data/datasources/sprints_remote_data_source.dart';
import 'package:scrumit/features/sprints/data/repositories/sprint_repository.dart';
import 'package:scrumit/features/sprints/domain/contracts/sprints_contract.dart';
import 'package:scrumit/features/sprints/domain/usecases/sprint_usecases.dart';
import 'package:scrumit/features/sprints/presentation/controllers/sprint_controller.dart';
import 'package:scrumit/features/sprints/presentation/controllers/task_controller.dart';

Future<void> init() async {
  ///follow the call-flow
//   ///Features - projects
//   ///State Management
//   ///should be registers as factory not singleton
  Get.lazyPut(
      () => SprintController(Get.find(), Get.find(), Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut(
      () => TaskController(Get.find(), Get.find(), Get.find(), Get.find()),
      fenix: true);

  ///use cases
  ///singleton
  Get.lazyPut(() => GetSprintsList(Get.find()), fenix: true);
  Get.lazyPut(() => CreateSprint(Get.find()), fenix: true);
  Get.lazyPut(() => UpdateSprint(Get.find()), fenix: true);
  Get.lazyPut(() => GetSprintDetails(Get.find()), fenix: true);

  Get.lazyPut(() => GetTaslDetails(Get.find()), fenix: true);
  Get.lazyPut(() => GetTaslsList(Get.find()), fenix: true);
  Get.lazyPut(() => UpdateTask(Get.find()), fenix: true);
  Get.lazyPut(() => CreateTask(Get.find()), fenix: true);

  ///Repository
  ///singleton
  Get.lazyPut<SprintContract>(() => SprintRepository(Get.find()), fenix: true);

  ///Data sources
  ///singleton
  Get.lazyPut<SprintRemoteDataSourceContract>(
      () => SprintRemoteDataSource(Get.find()),
      fenix: true);

  ///Core
  ///singleton
  // Get.lazyPut(() => AppWrite(), fenix: true);

//   ///External librarries
//   /// singleton
}
