import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/app_dependencies.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _authController = getIt<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ListenableBuilder(
            listenable: _authController,
            builder: (context, _) {
              if (_authController.isAuthenticated) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.go(AppRoutes.home);
                });
              }

              if (_authController.error != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.showSnackBar(_authController.error!, isError: true);
                  _authController.clearError();
                });
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24.h),
                  const RegisterForm(),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Já tem uma conta?',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: context.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: _authController.isLoading
                            ? null
                            : () => context.pop(),
                        child: const Text('Entrar'),
                      ),
                    ],
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
