import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class StickerGridItem extends StatelessWidget {
  const StickerGridItem({
    super.key,
    required this.number,
    required this.name,
    this.isOwned = false,
    this.repeatedCount = 0,
    this.onTap,
    this.onLongPress,
  });

  final String number;
  final String name;
  final bool isOwned;
  final int repeatedCount;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isOwned
        ? AppColors.stickerOwned.withValues(alpha: 0.15)
        : context.isDark
            ? AppColorsDark.stickerMissing
            : AppColorsLight.stickerMissing;

    final borderColor = isOwned ? AppColors.stickerOwned : context.border;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      number,
                      style: AppTextStyles.h4.copyWith(
                        color: isOwned
                            ? AppColors.stickerOwned
                            : context.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        name,
                        style: AppTextStyles.caption.copyWith(
                          color: context.textTertiary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (isOwned)
                Positioned(
                  top: 4.w,
                  right: 4.w,
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: 16.w,
                    color: AppColors.stickerOwned,
                  ),
                ),
              if (repeatedCount > 0)
                Positioned(
                  bottom: 4.w,
                  right: 4.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.stickerRepeated,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      '+$repeatedCount',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
