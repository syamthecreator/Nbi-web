import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography definitions matching the client's approved Montserrat and Inter styling.
class AppTypography {
  AppTypography._();

  // Headings with Montserrat
  static TextStyle splashTitle({
    double fontSize = 42,
    FontWeight fontWeight = FontWeight.w800,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: -0.5,
      color: AppColors.textDark,
      height: 1.15,
    );
  }

  static TextStyle heading1({
    double fontSize = 28,
    FontWeight fontWeight = FontWeight.w800,
    Color color = AppColors.textHeading,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: -0.5,
      height: 1.2,
    );
  }

  static TextStyle heading2({
    double fontSize = 22,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.textHeading,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: -0.3,
      height: 1.25,
    );
  }

  static TextStyle heading3({
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.textHeading,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.3,
    );
  }

  static TextStyle subtitle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
    Color color = AppColors.textMuted,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.45,
    );
  }

  static TextStyle bodyMedium({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
    Color color = AppColors.textBody,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.5,
    );
  }

  static TextStyle bodySmall({
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.textBody,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.4,
    );
  }

  static TextStyle bodyBold({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.textHeading,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.4,
    );
  }

  static TextStyle buttonText({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w700,
    Color color = Colors.white,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 0.2,
    );
  }

  static TextStyle label({
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w700,
    Color color = const Color(0xFF111111),
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle caption({
    double fontSize = 13,
    FontWeight fontWeight = FontWeight.w500,
    Color color = AppColors.textMuted,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
