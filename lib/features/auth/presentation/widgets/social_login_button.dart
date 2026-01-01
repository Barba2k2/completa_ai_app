import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.isLoading = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? context.surfaceVariant;
    final fgColor = foregroundColor ?? context.colorScheme.onSurface;
    final isDisabled = onPressed == null || isLoading;

    return Material(
      color: isDisabled ? bgColor.withValues(alpha: 0.6) : bgColor,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: fgColor,
                  ),
                )
              else
                Icon(
                  icon,
                  size: 24.w,
                  color: fgColor,
                ),
              SizedBox(width: 12.w),
              Text(
                label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: fgColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
