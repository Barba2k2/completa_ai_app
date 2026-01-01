import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  bool get isDark => theme.brightness == Brightness.dark;

  Color get surfaceVariant =>
      isDark ? AppColorsDark.surfaceVariant : AppColorsLight.surfaceVariant;

  Color get textSecondary =>
      isDark ? AppColorsDark.textSecondary : AppColorsLight.textSecondary;

  Color get textTertiary =>
      isDark ? AppColorsDark.textTertiary : AppColorsLight.textTertiary;

  Color get border => isDark ? AppColorsDark.border : AppColorsLight.border;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  EdgeInsets get padding => mediaQuery.padding;

  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  bool get isKeyboardOpen => viewInsets.bottom > 0;

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : null,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<T?> showAppBottomSheet<T>({required Widget child}) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => child,
    );
  }
}
