import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 64.w,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Scanner de Figurinhas',
                style: AppTextStyles.h3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                'Em breve você poderá escanear o código das figurinhas para adicioná-las automaticamente à sua coleção.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.info.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 20.w,
                      color: AppColors.info,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Funcionalidade em desenvolvimento',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.info,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
