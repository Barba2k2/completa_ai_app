import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class ResetEmailSuccess extends StatelessWidget {
  const ResetEmailSuccess({
    super.key,
    required this.onBackPressed,
  });

  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.mark_email_read_outlined,
          size: 64.w,
          color: context.colorScheme.primary,
        ),
        SizedBox(height: 24.h),
        Text(
          'E-mail enviado!',
          style: AppTextStyles.h3,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          'Verifique sua caixa de entrada e siga as instruções para redefinir sua senha.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32.h),
        FilledButton(
          onPressed: onBackPressed,
          child: const Text('Voltar para login'),
        ),
      ],
    );
  }
}
