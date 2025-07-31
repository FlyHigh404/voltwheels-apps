import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'app_pallete.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppPallete.whiteColor,
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    iconTheme: const IconThemeData(color: AppPallete.blackColor),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPallete.primaryColor,
      primary: AppPallete.primaryColor,
      secondary: AppPallete.secondaryColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPallete.whiteColor,
      elevation: 2,
      selectedLabelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppPallete.primaryColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      prefixIconColor: AppPallete.iconColor,

    ),
  );
}
