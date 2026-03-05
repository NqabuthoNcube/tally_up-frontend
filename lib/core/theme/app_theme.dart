import 'package:flutter/material.dart';

class AppTheme {

  /// BRAND COLOR
  static const Color primary = Color(0xFF0E8A7E);

  /// LIGHT MODE COLORS
  static const Color lightBackground = Color(0xFFF5F6F8);
  static const Color lightCard = Colors.white;

  /// DARK MODE COLORS
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkCard = Color(0xFF1E293B);

  /// ----------------------
  /// LIGHT THEME
  /// ----------------------
  static ThemeData lightTheme = ThemeData(

    brightness: Brightness.light,

    scaffoldBackgroundColor: lightBackground,

    primaryColor: primary,

    fontFamily: "Lato",

    /// ICON VISIBILITY FIX
    iconTheme: const IconThemeData(
      color: Colors.black87,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.black),
    ),

    cardColor: lightCard,

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );

  /// ----------------------
  /// DARK THEME
  /// ----------------------
  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,

    scaffoldBackgroundColor: darkBackground,

    primaryColor: primary,

    fontFamily: "Lato",

    /// ICON VISIBILITY FIX
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    cardColor: darkCard,

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey,
      backgroundColor: darkCard,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}