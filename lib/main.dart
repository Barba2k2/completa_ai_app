import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_constants.dart';
import 'core/di/app_dependencies.dart';
import 'core/theme/app_theme.dart';
import 'features/profile/controllers/theme_controller.dart';
import 'routing/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const CompletaAiApp());
}

class CompletaAiApp extends StatelessWidget {
  const CompletaAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = getIt<ThemeController>();

    return ListenableBuilder(
      listenable: themeController,
      builder: (context, _) {
        return ScreenUtilInit(
          designSize: const Size(
            AppConstants.designWidth,
            AppConstants.designHeight,
          ),
          minTextAdapt: true,
          splitScreenMode: false,
          builder: (context, child) {
            return MaterialApp.router(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeController.themeMode.toThemeMode(),
              routerConfig: appRouter,
            );
          },
        );
      },
    );
  }
}
