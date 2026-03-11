/// core/theme/theme_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme state controller
class ThemeController extends StateNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.system);

  /// Switch to light theme
  void setLight() {
    state = ThemeMode.light;
  }

  /// Switch to dark theme
  void setDark() {
    state = ThemeMode.dark;
  }

  /// Follow system theme
  void setSystem() {
    state = ThemeMode.system;
  }

  /// Toggle between light and dark
  void toggleTheme() {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }
}

/// Riverpod provider
final themeProvider =
    StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  return ThemeController();
});