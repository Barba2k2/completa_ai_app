import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../widgets/social_login_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;

  Future<void> _signInWithApple() async {
    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final credential = await authService.signInWithApple();

      if (credential != null && mounted) {
        context.go(AppRoutes.home);
      }
    } catch (e) {
      log('Apple login error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao fazer login com Apple.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final credential = await authService.signInWithGoogle();

      if (credential != null && mounted) {
        context.go(AppRoutes.home);
      }
    } catch (e) {
      log('Login error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao fazer login. Tente novamente.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAppleSupported = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
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
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _signInWithGoogle,
              ),
              SizedBox(height: 12.h),
              SocialLoginButton(
                icon: Icons.apple_rounded,
                label: 'Continuar com Apple',
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                onPressed:
                    _isLoading || !isAppleSupported ? null : _signInWithApple,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'ou',
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 24.h),
              OutlinedButton(
                onPressed:
                    _isLoading ? null : () => context.push(AppRoutes.emailLogin),
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
          ),
        ),
      ),
    );
  }
}
