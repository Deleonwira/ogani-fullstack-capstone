import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Theme Colors from Tailwind config
  static const Color primary = Color(0xFF3B6934);
  static const Color primaryContainer = Color(0xFF2D5A27);
  static const Color onPrimary = Color(0xFFFFFFFF);
  
  static const Color secondary = Color(0xFF9B4500);
  static const Color secondaryContainer = Color(0xFFFC8A40);
  static const Color onSecondaryContainer = Color(0xFF516857);
  static const Color onSecondary = Color(0xFFFFFFFF);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceBright = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F4F8);
  static const Color surfaceContainerHighest = Color(0xFFE0E3E8);
  static const Color surfaceContainerLow = Color(0xFFFAFAFA);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF181C20);
  static const Color onSurfaceVariant = Color(0xFF42493E);

  static const Color outline = Color(0xFF72796E);
  static const Color outlineVariant = Color(0xFFC2C9BB);
  
  static const Color tertiary = Color(0xFF785900);
  static const Color tertiaryContainer = Color(0xFFC49400);
  static const Color tertiaryFixedDim = Color(0xFFFABD00);

  static const Color error = Color(0xFFBA1A1A);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimary: onPrimary,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        onSecondary: onSecondary,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        error: error,
        outline: outline,
        outlineVariant: outlineVariant,
      ),
      scaffoldBackgroundColor: surface,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(fontSize: 34, fontWeight: FontWeight.w700, letterSpacing: -1.0),
        displayMedium: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.8),
        headlineMedium: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.6),
        titleLarge: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.5),
        bodyLarge: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: -0.2),
        bodyMedium: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: -0.1),
        labelLarge: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.0),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: primary,
        elevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
