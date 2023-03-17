import 'package:get/get.dart';
import 'package:scrumit/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:scrumit/features/auth/data/repositories/auth_repository.dart';
import 'package:scrumit/features/auth/domain/contracts/auth_contract.dart';
import 'package:scrumit/features/auth/domain/usecases/auth_usecases.dart';
import 'package:scrumit/features/auth/presentation/controllers/auth_controller.dart';

Future<void> init() async {
  ///follow the call-flow
//   ///Features - projects
//   ///State Management
//   ///should be registers as factory not singleton
  Get.lazyPut(() => AuthController(
      login: Get.find(),
      signup: Get.find(),
      getAccount: Get.find(),
      logout: Get.find()));

  ///use cases
  ///singleton
  Get.lazyPut(() => GetAccount(Get.find()), fenix: true);
  Get.lazyPut(() => Login(Get.find()), fenix: true);
  Get.lazyPut(() => Signup(Get.find()), fenix: true);
  Get.lazyPut(() => Logout(Get.find()));

  ///Repository
  ///singleton
  Get.lazyPut<AuthContract>(() => AuthRepository(Get.find()), fenix: true);

  ///Data sources
  ///singleton
  Get.lazyPut<AuthRemoteDataSourceContract>(
      () => AuthRemoteDataSource(Get.find()),
      fenix: true);

  ///Core
  ///singleton
  // Get.lazyPut(() => AppWrite(), fenix: true);

//   ///External librarries
//   /// singleton
}
