// Em lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF0F1A21), 
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0F1A21), 
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600, 
        fontFamily: 'Montserrat', 
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600, 
        fontFamily: 'Montserrat',
      ),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
    ).copyWith(
      secondary: const Color(0xFF0F1A21),
    ),
    cardTheme: const CardThemeData(
      color: Color(0xFF1B2B33), 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)), 
      ),
      elevation: 4,
    ),
  );
}