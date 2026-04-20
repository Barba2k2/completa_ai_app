import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/app_dependencies.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';
import '../../controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authController = getIt<AuthController>();

  @override
  void initState() {
    super.initState();
    _authController.checkInitialAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: ListenableBuilder(
        listenable: _authController,
        builder: (context, _) {
          if (_authController.splashCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final route = _authController.isAuthenticated
                  ? AppRoutes.home
                  : AppRoutes.login;
              context.go(route);
            });
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.collections_bookmark_rounded,
                  size: 80.w,
                  color: Colors.white,
                ),
                SizedBox(height: 24.h),
                Text(
                  AppConstants.appName,
                  style: AppTextStyles.h1.copyWith(color: Colors.white),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Álbum Copa 2026',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
