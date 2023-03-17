import 'package:get/get.dart';
import 'package:scrumit/features/meetings/data/datasources/meeting_datasource.dart';
import 'package:scrumit/features/meetings/data/repos/meeting_repo.dart';
import 'package:scrumit/features/meetings/domain/contracts/meeting_contract.dart';
import 'package:scrumit/features/meetings/domain/usecases/meetings_usecases.dart';
import 'package:scrumit/features/meetings/presentaion/controller/meeting_controller.dart';

Future<void> init() async {
  ///follow the call-flow
//   ///Features - projects
//   ///State Management
//   ///should be registers as factory not singleton
  Get.lazyPut(
      () => MeetingController(
            Get.find(),
          ),
      fenix: true);

  ///use cases
  ///singleton
  Get.lazyPut(() => JoinMeeting(Get.find()), fenix: true);

  ///Repository
  ///singleton
  Get.lazyPut<MeetingContract>(() => MeetingRepository(Get.find()),
      fenix: true);

  ///Data sources
  ///singleton
  Get.lazyPut<MeetingRemoteDataSourceContract>(
      () => MeetingRemoteDataSource(Get.find()),
      fenix: true);

  ///Core
  ///singleton
  // Get.lazyPut(() => AppWrite(), fenix: true);

//   ///External librarries
//   /// singleton
}
