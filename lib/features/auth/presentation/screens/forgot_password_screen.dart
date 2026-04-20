import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/app_dependencies.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/forgot_password_form.dart';
import '../widgets/reset_email_success.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _authController = getIt<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar senha'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ListenableBuilder(
            listenable: _authController,
            builder: (context, _) {
              if (_authController.error != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.showSnackBar(_authController.error!, isError: true);
                  _authController.clearError();
                });
              }

              if (_authController.resetEmailSent) {
                return ResetEmailSuccess(
                  onBackPressed: () {
                    _authController.clearResetEmailSent();
                    context.pop();
                  },
                );
              }

              return const ForgotPasswordForm();
            },
          ),
        ),
      ),
    );
  }
}
