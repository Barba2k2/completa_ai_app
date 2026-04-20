import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o app'),
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          Center(
            child: Icon(
              Icons.collections_bookmark_rounded,
              size: 80.w,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            AppConstants.appName,
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Versão ${AppConstants.appVersion}',
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          Text(
            'Gerencie sua coleção de figurinhas da Copa do Mundo 2026 de forma fácil e organizada.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text('Política de Privacidade', style: AppTextStyles.bodyMedium),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutes.privacyPolicy),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text('Termos de Uso', style: AppTextStyles.bodyMedium),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutes.termsOfUse),
          ),
          SizedBox(height: 32.h),
          Text(
            '© 2026 ${AppConstants.appName}',
            style: AppTextStyles.caption.copyWith(
              color: context.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
