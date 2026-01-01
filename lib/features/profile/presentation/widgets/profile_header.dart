import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
  });

  final dynamic profile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(AppRoutes.editProfile),
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 36.r,
              backgroundColor: context.surfaceVariant,
              backgroundImage:
                  profile?.photoUrl != null ? NetworkImage(profile.photoUrl) : null,
              child: profile?.photoUrl == null
                  ? Icon(
                      Icons.person_rounded,
                      size: 36.w,
                      color: context.textSecondary,
                    )
                  : null,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile?.displayName ?? 'Usuário',
                    style: AppTextStyles.h4,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    profile?.email ?? '',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: context.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: context.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
