/// core/theme/app_colors.dart
library;

import 'package:flutter/material.dart';

class AppColors {
  /// Brand — bright green from UI designs
  static const brandGreen = Color(0xFF2ECC71);
  static const brandGreenDark = Color(0xFF27AE60);

  /// Keep teal as accent for compatibility
  static const primary = Color(0xFF2ECC71);
  static const primaryDark = Color(0xFF27AE60);
  static const accent = Color(0xFF1ABC9C);

  /// Light theme
  static const lightBackground = Color(0xFFF5F6F8);
  static const lightCard = Colors.white;

  static const lightTextPrimary = Color(0xFF111827);
  static const lightTextSecondary = Color(0xFF6B7280);

  /// Dark theme
  static const darkBackground = Color(0xFF0F172A);
  static const darkCard = Color(0xFF1E293B);

  static const darkTextPrimary = Colors.white;
  static const darkTextSecondary = Color(0xFF94A3B8);

  /// Status
  static const success = Color(0xFF22C55E);
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);
}
