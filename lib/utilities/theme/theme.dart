import 'package:flutter/material.dart';
import 'package:temp_project/utilities/theme/widget_themes/user_input_box_theme.dart';

import '../constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    inputDecorationTheme: UserInputBoxTheme.lightUserInputBoxTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kPaleGoldenrod.withAlpha(150),
      elevation: 0,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.kDarkGreen,
      ),
      iconTheme: const IconThemeData(color: AppColors.kDarkGreen), // Dark green
    ),
  );
}
