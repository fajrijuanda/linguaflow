import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Static map similar to web constants
  static const Map<String, Map<String, Color>> themeColors = {
    'KR': {
      'primary': Color(0xFF0047A0),
      'accent': Color(0xFFCD2E3A),
      'background': Colors.white,
    },
    'JP': {
      'primary': Color(0xFFBC002D),
      'accent': Color(0xFFB5B5B5),
      'background': Colors.white,
    },
    'CN': {
      'primary': Color(0xFFDE2910),
      'accent': Color(0xFFFFDE00),
      'background': Colors.white,
    },
    'EN': {
      'primary': Color(0xFF00247D),
      'accent': Color(0xFFCF142B),
      'background': Color(0xFFF8FAFC),
    },
    'ID': {
      'primary': Color(0xFFFF0000),
      'accent': Color(0xFFFFFFFF),
      'background': Colors.white,
    },
  };
}

class AppTheme {
  static ThemeData getTheme(String langCode) {
    final colors = AppColors.themeColors[langCode] ?? AppColors.themeColors['EN']!;
    final primary = colors['primary']!;
    final background = colors['background']!;

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        background: background,
      ),
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: primary,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: primary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}
