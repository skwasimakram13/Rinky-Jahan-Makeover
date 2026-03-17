import 'package:flutter/material.dart';

class AppTheme {
  // Primary color: Rose gold #C9847A
  static const Color primaryColor = Color(0xFFC9847A);
  
  // Background: Champagne cream #F5EFE6
  static const Color backgroundColor = Color(0xFFF5EFE6);
  
  // Card surface: Blush pink #F2D6D0
  static const Color cardColor = Color(0xFFF2D6D0);
  
  // Text: Charcoal #2C2C2C
  static const Color textColor = Color(0xFF2C2C2C);
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        background: backgroundColor,
        surface: cardColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: true,
      ),
      // Buttons: fully rounded pill shape
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          shape: const StadiumBorder(),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          shape: const StadiumBorder(),
        ),
      ),
      // Cards: rounded-lg with soft shadow
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
