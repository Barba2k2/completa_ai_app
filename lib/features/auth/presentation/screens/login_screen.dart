import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/app_dependencies.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/social_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = getIt<AuthController>();
    final isAppleSupported = Platform.isIOS;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ListenableBuilder(
            listenable: authController,
            builder: (context, _) {
              if (authController.isAuthenticated) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.go(AppRoutes.home);
                });
              }

              if (authController.error != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.showSnackBar(authController.error!, isError: true);
                  authController.clearError();
                });
              }

              final isLoading = authController.isLoading;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 60.h),
                  Icon(
                    Icons.collections_bookmark_rounded,
                    size: 64.w,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    AppConstants.appName,
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Gerencie sua coleção de figurinhas',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: context.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48.h),
                  SocialLoginButton(
                    icon: Icons.g_mobiledata_rounded,
                    label: 'Continuar com Google',
                    isLoading: isLoading,
                    onPressed: isLoading
                        ? null
                        : authController.signInWithGoogle,
                  ),
                  SizedBox(height: 12.h),
                  SocialLoginButton(
                    icon: Icons.apple_rounded,
                    label: 'Continuar com Apple',
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    onPressed: isLoading || !isAppleSupported
                        ? null
                        : authController.signInWithApple,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'ou',
                          style: AppTextStyles.bodySmall,
                        ),
                      ),
                      const Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  OutlinedButton(
                    onPressed: isLoading
                        ? null
                        : () => context.push(AppRoutes.emailLogin),
                    child: const Text('Entrar com e-mail'),
                  ),
                  const Spacer(),
                  Text(
                    'Ao continuar, você concorda com nossos\nTermos de Uso e Política de Privacidade',
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
