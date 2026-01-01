import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import 'stat_item.dart';

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
          StatItem(
            value: ownedCount.toString(),
            label: 'Coletadas',
            color: AppColors.stickerOwned,
          ),
          Container(
            width: 1,
            height: 40.h,
            color: context.border,
          ),
          StatItem(
            value: repeatedCount.toString(),
            label: 'Repetidas',
            color: AppColors.stickerRepeated,
          ),
          Container(
            width: 1,
            height: 40.h,
            color: context.border,
          ),
          StatItem(
            value: '$progress%',
            label: 'Progresso',
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
