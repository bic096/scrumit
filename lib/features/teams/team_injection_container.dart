import 'package:get/get.dart';
import 'package:scrumit/features/teams/data/datasources/team_remote_data_sourse.dart';
import 'package:scrumit/features/teams/data/repositories/team_repository.dart';
import 'package:scrumit/features/teams/domain/contracts/team_contract.dart';
import 'package:scrumit/features/teams/domain/usecases/teams_usecases.dart';
import 'package:scrumit/features/teams/presentation/controllers/team_controller.dart';

Future<void> init() async {
  ///follow the call-flow
//   ///Features - projects
//   ///State Management
//   ///should be registers as factory not singleton
  Get.lazyPut(
      () => TeamController(Get.find(), Get.find(), Get.find(), Get.find()));

  ///use cases
  ///singleton
  Get.lazyPut(() => GetTeamMemberList(Get.find()), fenix: true);
  Get.lazyPut(() => AddTeamMember(Get.find()), fenix: true);
  Get.lazyPut(() => DeleteTeamMember(Get.find()), fenix: true);
  Get.lazyPut(() => GetUSerTeamsList(Get.find()), fenix: true);

  ///Repository
  ///singleton
  Get.lazyPut<TeamContract>(() => TeamRepository(Get.find()), fenix: true);

  ///Data sources
  ///singleton
  Get.lazyPut<TeamRemoteDataSourceContract>(
      () => TeamRemoteDataSource(Get.find()),
      fenix: true);

  ///Core
  ///singleton
  // Get.lazyPut(() => AppWrite(), fenix: true);

//   ///External librarries
//   /// singleton
}
