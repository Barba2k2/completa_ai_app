import 'package:get_it/get_it.dart';

import '../network/api_client.dart';
import '../../features/auth/controllers/auth_controller.dart';
import '../../features/collection/controllers/collection_controller.dart';
import '../../features/collection/controllers/section_detail_controller.dart';
import '../../features/collection/controllers/stickers_controller.dart';
import '../../features/home/controllers/home_controller.dart';
import '../../features/home/controllers/sections_controller.dart';
import '../../features/profile/controllers/profile_controller.dart';
import '../../features/profile/controllers/profile_screen_controller.dart';
import '../../features/profile/controllers/theme_controller.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  getIt.registerLazySingleton<AuthController>(() => AuthController());

  getIt.registerLazySingleton<ThemeController>(() => ThemeController());

  getIt.registerLazySingleton<CollectionController>(
    () => CollectionController(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<SectionsController>(
    () => SectionsController(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<StickersController>(
    () => StickersController(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<HomeController>(() => HomeController());

  getIt.registerLazySingleton<ProfileController>(() => ProfileController());

  getIt.registerLazySingleton<ProfileScreenController>(
    () => ProfileScreenController(),
  );

  getIt.registerLazySingleton<SectionDetailController>(
    () => SectionDetailController(),
  );
}
