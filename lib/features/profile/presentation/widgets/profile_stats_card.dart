import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({
    super.key,
    required this.ownedCount,
    required this.repeatedCount,
    required this.progress,
  });

  final int ownedCount;
  final int repeatedCount;
  final String progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.surfaceVariant,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            value: ownedCount.toString(),
            label: 'Coletadas',
            color: AppColors.stickerOwned,
          ),
          Container(
            width: 1,
            height: 40.h,
            color: context.border,
          ),
          _StatItem(
            value: repeatedCount.toString(),
            label: 'Repetidas',
            color: AppColors.stickerRepeated,
          ),
          Container(
            width: 1,
            height: 40.h,
            color: context.border,
          ),
          _StatItem(
            value: '$progress%',
            label: 'Progresso',
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h3.copyWith(color: color),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: context.textSecondary,
          ),
        ),
      ],
    );
  }
}
