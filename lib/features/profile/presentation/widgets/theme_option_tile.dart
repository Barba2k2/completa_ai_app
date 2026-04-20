import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/enums/app_theme_mode.dart';

class ThemeOptionTile extends StatelessWidget {
  const ThemeOptionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.currentTheme,
    required this.onSelected,
  });

  final String title;
  final String subtitle;
  final AppThemeMode value;
  final AppThemeMode currentTheme;
  final ValueChanged<AppThemeMode> onSelected;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentTheme == value;

    final iconColor = context.isDark ? Colors.white : Colors.grey[700];

    return ListTile(
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: iconColor,
      ),
      title: Text(title, style: AppTextStyles.bodyMedium),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.caption.copyWith(color: context.textSecondary),
      ),
      onTap: () => onSelected(value),
    );
  }
}
