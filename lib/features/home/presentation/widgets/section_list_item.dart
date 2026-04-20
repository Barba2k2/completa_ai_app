import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SectionListItem extends StatelessWidget {
  const SectionListItem({
    super.key,
    required this.title,
    required this.code,
    required this.collected,
    required this.total,
    required this.onTap,
  });

  final String title;
  final String code;
  final int collected;
  final int total;
  final VoidCallback onTap;

  double get progress => collected / total;

  bool get isComplete => collected == total;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: isComplete
                      ? AppColors.success.withValues(alpha: 0.1)
                      : context.surfaceVariant,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  code,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: isComplete ? AppColors.success : context.textSecondary,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.labelLarge,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2.r),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 4.h,
                              backgroundColor: context.surfaceVariant,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isComplete ? AppColors.success : AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '$collected/$total',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.chevron_right_rounded,
                color: context.textTertiary,
                size: 24.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
