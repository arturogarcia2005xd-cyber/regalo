import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lu/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.nightNavy,
      primaryColor: AppColors.lavenderGlow,
      cardColor: AppColors.oceanDeep.withOpacity(0.7),
      textTheme: TextTheme(
        // Títulos principales estilo cuento
        displayLarge: GoogleFonts.comfortaa(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.starlightYellow,
        ),
        // Subtítulos
        titleLarge: GoogleFonts.quicksand(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.warmWhite,
        ),
        // Texto de la carta (Tipografía de carta escrita a mano)
        bodyLarge: GoogleFonts.caveat(
          fontSize: 24,
          height: 1.4,
          color: AppColors.warmWhite,
        ),
        bodyMedium: GoogleFonts.quicksand(
          fontSize: 14,
          color: AppColors.mutedText,
        ),
      ),
    );
  }
}