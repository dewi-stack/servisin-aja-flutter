import 'package:flutter/material.dart';

class AppColors {
  static const orange = Color(0xFFF26114);
  static const orangeDark = Color(0xFFD84E0C);
  static const softOrange = Color(0xFFFFF0E3);
  static const background = Color(0xFFF9F9FA);
  static const dark = Color(0xFF14171F);
  static const muted = Color(0xFF6B707A);
  static const border = Color(0xFFDEE0E5);
  static const success = Color(0xFF1FA05A);
  static const softSuccess = Color(0xFFE6F7ED);
  static const warning = Color(0xFFF2A800);
  static const softWarning = Color(0xFFFFF6DF);
  static const error = Color(0xFFC92B2B);
}

class AppRadii {
  static const card = 16.0;
  static const control = 12.0;
  static const button = 14.0;
}

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orange),
      fontFamily: 'Inter',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: AppColors.muted, fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.control),
          borderSide: const BorderSide(color: AppColors.orange, width: 1.4),
        ),
      ),
    );
  }
}
