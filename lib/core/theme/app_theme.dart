import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: AppTextStyles.headline1,
    ),
    textTheme: const TextTheme(
      bodyLarge: AppTextStyles.bodyText1,
    ),
    brightness: Brightness.dark,
  );
}