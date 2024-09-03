import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../base/util/color.dart';
import '../../base/util/size.dart';

class Themes {
  SizeUtility get sizes => SizeUtility();
  ThemeData get light => ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: ColorUtility.primary,
          onPrimary: ColorUtility.onPrimary,
          secondary: ColorUtility.secondary,
          onSecondary: ColorUtility.onSecondary,
          background: ColorUtility.background,
          onBackground: ColorUtility.onBackground,
          surface: ColorUtility.surface,
          onSurface: ColorUtility.onSurface,
          error: ColorUtility.error,
        ),
        primaryColor: ColorUtility.primary,
        scaffoldBackgroundColor: ColorUtility.background,
        appBarTheme: const AppBarTheme(),
        inputDecorationTheme: const InputDecorationTheme(),
        textTheme: const TextTheme().copyWith(
          headlineLarge: GoogleFonts.quicksand(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
          ),
          headlineMedium: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.w600, letterSpacing: 0),
          headlineSmall: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 0),
          labelLarge: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0),
          titleSmall: GoogleFonts.quicksand(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0),
          titleMedium: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0),
          titleLarge: GoogleFonts.quicksand(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 0),
          labelSmall: GoogleFonts.quicksand(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedLabelStyle: GoogleFonts.quicksand(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0),
          selectedLabelStyle: GoogleFonts.quicksand(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0),
          unselectedItemColor: ColorUtility.onSecondary,
        ),
      );
  final dark = ThemeData.dark();
}
