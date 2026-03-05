import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod provider
final themeProvider =
    StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  return ThemeController();
});

class ThemeController extends StateNotifier<ThemeMode> {

  ThemeController() : super(ThemeMode.system);

  /// Set light mode
  void setLight() {
    state = ThemeMode.light;
  }

  /// Set dark mode
  void setDark() {
    state = ThemeMode.dark;
  }

  /// Use system theme
  void setSystem() {
    state = ThemeMode.system;
  }

  /// Toggle quickly
  void toggleTheme() {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }
}