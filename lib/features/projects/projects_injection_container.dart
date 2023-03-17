import 'package:get/get.dart';
import 'package:scrumit/features/projects/data/datasources/project_remote_data_source.dart';
import 'package:scrumit/features/projects/data/repositories/project_repository.dart';
import 'package:scrumit/features/projects/domain/contracts/project_contract.dart';
import 'package:scrumit/features/projects/domain/usecases/project_usecases.dart';
import 'package:scrumit/features/projects/presentation/controllers/release_backlog_controller.dart';
import 'package:scrumit/features/projects/presentation/controllers/product_backlog_controller.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';

Future<void> init() async {
  ///follow the call-flow
//   ///Features - projects
//   ///State Management
//   ///should be registers as factory not singleton
  Get.lazyPut(
      () => ProjectController(
            createProject: Get.find(),
            getProject: Get.find(),
            getProjectList: Get.find(),
          ),
      fenix: true);

  Get.lazyPut(
      () => ProductBacklogController(
          createProductBacklog: Get.find(),
          getProductBacklog: Get.find(),
          getProductBacklogList: Get.find(),
          updateProductBacklog: Get.find()),
      fenix: true);

  Get.lazyPut(
      () => ReleaseBacklogController(
          createReleaseBacklog: Get.find(),
          getReleaseBacklog: Get.find(),
          getReleaseBacklogList: Get.find(),
          updateReleaseBacklog: Get.find()),
      fenix: true);

  ///use cases
  ///singleton
  Get.lazyPut(() => CreateProject(Get.find()), fenix: true);
  Get.lazyPut(() => GetProject(Get.find()), fenix: true);
  Get.lazyPut(() => GetProjectList(Get.find()), fenix: true);
  Get.lazyPut(() => UpdateProject(Get.find()), fenix: true);

  Get.lazyPut(() => CreateProductBacklog(Get.find()), fenix: true);
  Get.lazyPut(() => GetProductBacklog(Get.find()), fenix: true);
  Get.lazyPut(() => GetProductBacklogList(Get.find()), fenix: true);
  Get.lazyPut(() => UpdateProductBacklog(Get.find()), fenix: true);

  Get.lazyPut(() => CreateReleaseBacklog(Get.find()), fenix: true);
  Get.lazyPut(() => GetReleaseBacklog(Get.find()), fenix: true);
  Get.lazyPut(() => GetReleaseBacklogList(Get.find()), fenix: true);
  Get.lazyPut(() => UpdateReleaseBacklog(Get.find()), fenix: true);

  ///Repository
  ///singleton
  Get.lazyPut<ProjectContract>(
      () => ProjectRepository(projectRemoteDataSourceContract: Get.find()),
      fenix: true);

  ///Data sources
  ///singleton
  Get.lazyPut<ProjectRemoteDataSourceContract>(
      () => ProjectRemoteDataSource(appWrite: Get.find()),
      fenix: true);

  ///Core
  ///singleton
  // Get.lazyPut(() => AppWrite(), fenix: true);

//   ///External librarries
//   /// singleton
}
