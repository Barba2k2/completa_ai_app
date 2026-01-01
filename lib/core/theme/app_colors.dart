import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary - Neutral gray palette
  static const primary = Color(0xFF1A1A1A);
  static const primaryLight = Color(0xFF2D2D2D);
  static const primaryDark = Color(0xFF0D0D0D);

  // Secondary - Subtle accent
  static const secondary = Color(0xFF6B7280);
  static const secondaryLight = Color(0xFF9CA3AF);
  static const secondaryDark = Color(0xFF4B5563);

  // Status
  static const success = Color(0xFF10B981);
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);
  static const info = Color(0xFF3B82F6);

  // Sticker states
  static const stickerOwned = Color(0xFF10B981);
  static const stickerRepeated = Color(0xFF3B82F6);
}

abstract final class AppColorsLight {
  static const background = Color(0xFFFAFAFA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF3F4F6);

  static const textPrimary = Color(0xFF1F2937);
  static const textSecondary = Color(0xFF6B7280);
  static const textTertiary = Color(0xFF9CA3AF);

  static const border = Color(0xFFE5E7EB);
  static const borderLight = Color(0xFFF3F4F6);

  static const stickerMissing = Color(0xFFE5E7EB);

  static const shadow = Color(0x0A000000);
}

abstract final class AppColorsDark {
  static const background = Color(0xFF0F0F0F);
  static const surface = Color(0xFF1A1A1A);
  static const surfaceVariant = Color(0xFF262626);

  static const textPrimary = Color(0xFFF9FAFB);
  static const textSecondary = Color(0xFF9CA3AF);
  static const textTertiary = Color(0xFF6B7280);

  static const border = Color(0xFF374151);
  static const borderLight = Color(0xFF1F2937);

  static const stickerMissing = Color(0xFF374151);

  static const shadow = Color(0x1AFFFFFF);
}
