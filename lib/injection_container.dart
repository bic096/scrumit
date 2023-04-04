import 'package:get/get.dart';
import 'package:scrumit/core/datasource/appwrite.dart';
import 'package:scrumit/features/auth/auth_injection_container.dart' as auth;
import 'package:scrumit/features/projects/projects_injection_container.dart'
    as projects;
import 'package:scrumit/features/teams/team_injection_container.dart' as team;
import 'package:scrumit/features/sprints/sprint_injection_container.dart'
    as sprint;
import 'package:scrumit/features/meetings/meetings_injection_container.dart'
    as meeting;

Future<void> init() async {
  Get.lazyPut(() => AppWrite(), fenix: true);
  await auth.init();
  await team.init();
  await projects.init();
  await meeting.init();

  sprint.init();
}
//////***************************************************************************8 */
//   ///follow the call-flow
//   ///Features - projects
//   ///State Management
//   ///should be registers as factory not singleton
//   sl.registerLazySingleton(() => ProjectCotroller(
//       createProject: sl(), getProject: sl(), getProjectList: sl()));

//   ///use cases
//   ///singleton
//   sl.registerLazySingleton(() => CreateProject(sl()));
//   sl.registerLazySingleton(() => GetProject(sl()));
//   sl.registerLazySingleton(() => GetProjectList(sl()));

//   ///Repository
//   ///singleton
//   sl.registerLazySingleton<ProjectContract>(
//       () => ProjectRepository(projectRemoteDataSourceContract: sl()));

//   ///Data sources
//   ///singleton
//   sl.registerLazySingleton<ProjectRemoteDataSourceContract>(
//       () => ProjectRemoteDataSource(appWrite: sl()));

//   ///Core
//   ///singleton
//   sl.registerLazySingleton(() => AppWrite());

//   ///External librarries
//   /// singleton
// }
///********************************************************************** */
// Future<void> init() async {
//   //! Features - Number Trivia
//   // Bloc
//   sl.registerFactory(
//     () => NumberTriviaBloc(
//       concrete: sl(),
//       inputConverter: sl(),
//       random: sl(),
//     ),
//   );

//   // Use cases
//   sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
//   sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

//   // Repository
//   sl.registerLazySingleton<NumberTriviaRepository>(
//     () => NumberTriviaRepositoryImpl(
//       localDataSource: sl(),
//       networkInfo: sl(),
//       remoteDataSource: sl(),
//     ),
//   );

//   // Data sources
//   sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
//     () => NumberTriviaRemoteDataSourceImpl(client: sl()),
//   );

//   sl.registerLazySingleton<NumberTriviaLocalDataSource>(
//     () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
//   );

//   //! Core
//   sl.registerLazySingleton(() => InputConverter());
//   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//   //! External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => DataConnectionChecker());
// }



// import 'dart:convert';

// import 'package:efood_multivendor/controller/auth_controller.dart';
// import 'package:efood_multivendor/controller/banner_controller.dart';
// import 'package:efood_multivendor/controller/campaign_controller.dart';
// import 'package:efood_multivendor/controller/cart_controller.dart';
// import 'package:efood_multivendor/controller/category_controller.dart';
// import 'package:efood_multivendor/controller/coupon_controller.dart';
// import 'package:efood_multivendor/controller/localization_controller.dart';
// import 'package:efood_multivendor/controller/location_controller.dart';
// import 'package:efood_multivendor/controller/notification_controller.dart';
// import 'package:efood_multivendor/controller/onboarding_controller.dart';
// import 'package:efood_multivendor/controller/order_controller.dart';
// import 'package:efood_multivendor/controller/product_controller.dart';
// import 'package:efood_multivendor/controller/restaurant_controller.dart';
// import 'package:efood_multivendor/controller/search_controller.dart';
// import 'package:efood_multivendor/controller/splash_controller.dart';
// import 'package:efood_multivendor/controller/theme_controller.dart';
// import 'package:efood_multivendor/controller/user_controller.dart';
// import 'package:efood_multivendor/controller/wishlist_controller.dart';
// import 'package:efood_multivendor/data/repository/auth_repo.dart';
// import 'package:efood_multivendor/data/repository/banner_repo.dart';
// import 'package:efood_multivendor/data/repository/campaign_repo.dart';
// import 'package:efood_multivendor/data/repository/cart_repo.dart';
// import 'package:efood_multivendor/data/repository/category_repo.dart';
// import 'package:efood_multivendor/data/repository/coupon_repo.dart';
// import 'package:efood_multivendor/data/repository/language_repo.dart';
// import 'package:efood_multivendor/data/repository/location_repo.dart';
// import 'package:efood_multivendor/data/repository/notification_repo.dart';
// import 'package:efood_multivendor/data/repository/onboarding_repo.dart';
// import 'package:efood_multivendor/data/repository/order_repo.dart';
// import 'package:efood_multivendor/data/repository/product_repo.dart';
// import 'package:efood_multivendor/data/repository/restaurant_repo.dart';
// import 'package:efood_multivendor/data/repository/search_repo.dart';
// import 'package:efood_multivendor/data/repository/splash_repo.dart';
// import 'package:efood_multivendor/data/api/api_client.dart';
// import 'package:efood_multivendor/data/repository/user_repo.dart';
// import 'package:efood_multivendor/data/repository/wishlist_repo.dart';
// import 'package:efood_multivendor/util/app_constants.dart';
// import 'package:efood_multivendor/data/model/response/language_model.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get.dart';

// Future<void> init() async {
//   // Core
//   final sharedPreferences = await SharedPreferences.getInstance();
//   Get.lazyPut(() => sharedPreferences);
//   Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

//   // Repository
//   Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
//   Get.lazyPut(() => LanguageRepo());
//   Get.lazyPut(() => OnBoardingRepo());
//   Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
//   Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
//   Get.lazyPut(() => UserRepo(apiClient: Get.find()));
//   Get.lazyPut(() => BannerRepo(apiClient: Get.find()));
//   Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
//   Get.lazyPut(() => RestaurantRepo(apiClient: Get.find()));
//   Get.lazyPut(() => WishListRepo(apiClient: Get.find()));
//   Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
//   Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
//   Get.lazyPut(() => SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
//   Get.lazyPut(() => CouponRepo(apiClient: Get.find()));
//   Get.lazyPut(() => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
//   Get.lazyPut(() => NotificationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
//   Get.lazyPut(() => CampaignRepo(apiClient: Get.find()));

//   // Controller
//   Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
//   Get.lazyPut(() => SplashController(splashRepo: Get.find()));
//   Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
//   Get.lazyPut(() => OnBoardingController(onboardingRepo: Get.find()));
//   Get.lazyPut(() => AuthController(authRepo: Get.find()));
//   Get.lazyPut(() => LocationController(locationRepo: Get.find()));
//   Get.lazyPut(() => UserController(userRepo: Get.find()));
//   Get.lazyPut(() => BannerController(bannerRepo: Get.find()));
//   Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
//   Get.lazyPut(() => ProductController(productRepo: Get.find()));
//   Get.lazyPut(() => CartController(cartRepo: Get.find()));
//   Get.lazyPut(() => RestaurantController(restaurantRepo: Get.find()));
//   Get.lazyPut(() => WishListController(wishListRepo: Get.find(), productRepo: Get.find()));
//   Get.lazyPut(() => SearchController(searchRepo: Get.find()));
//   Get.lazyPut(() => CouponController(couponRepo: Get.find()));
//   Get.lazyPut(() => OrderController(orderRepo: Get.find()));
//   Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
//   Get.lazyPut(() => CampaignController(campaignRepo: Get.find()));

// }