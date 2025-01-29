import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Display Styles
  static TextStyle displayLarge = GoogleFonts.notoSansThai(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static TextStyle displayMedium = GoogleFonts.notoSansThai(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 0,
    height: 1.16,
  );

  static TextStyle displaySmall = GoogleFonts.notoSansThai(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 0,
    height: 1.22,
  );

  // Headline Styles
  static TextStyle h1 = GoogleFonts.notoSansThai(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.25,
  );

  static TextStyle h2 = GoogleFonts.notoSansThai(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.25,
    height: 1.29,
  );

  static TextStyle h3 = GoogleFonts.notoSansThai(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0,
    height: 1.33,
  );

  static TextStyle h4 = GoogleFonts.notoSansThai(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.15,
    height: 1.4,
  );

  // Body Text Styles
  static TextStyle bodyLarge = GoogleFonts.notoSansThai(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.notoSansThai(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static TextStyle bodySmall = GoogleFonts.notoSansThai(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // Button Text Styles
  static TextStyle button = GoogleFonts.notoSansThai(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static TextStyle buttonLarge = GoogleFonts.notoSansThai(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // Label Styles
  static TextStyle labelLarge = GoogleFonts.notoSansThai(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static TextStyle labelMedium = GoogleFonts.notoSansThai(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
    height: 1.33,
  );

  static TextStyle labelSmall = GoogleFonts.notoSansThai(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
    height: 1.45,
  );

  // Caption and Overline
  static TextStyle caption = GoogleFonts.notoSansThai(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
    height: 1.33,
  );

  static TextStyle overline = GoogleFonts.notoSansThai(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 1.5,
    height: 1.6,
  );

  // Link Styles
  static TextStyle link = GoogleFonts.notoSansThai(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    letterSpacing: 0.25,
    height: 1.43,
    decoration: TextDecoration.underline,
  );

  // Error and Success Text
  static TextStyle error = GoogleFonts.notoSansThai(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
    letterSpacing: 0.4,
    height: 1.33,
  );

  static TextStyle success = GoogleFonts.notoSansThai(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.success,
    letterSpacing: 0.4,
    height: 1.33,
  );
}
