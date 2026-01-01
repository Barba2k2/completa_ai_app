import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProfileHeaderError extends StatelessWidget {
  const ProfileHeaderError({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 36.r,
          backgroundColor: context.surfaceVariant,
          child: Icon(
            Icons.error_outline_rounded,
            size: 36.w,
            color: context.colorScheme.error,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            'Erro ao carregar perfil',
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
