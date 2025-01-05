import 'package:flutter/material.dart';
import 'package:temp_project/utilities/theme/widget_themes/user_input_box_theme.dart';

import '../constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    inputDecorationTheme: UserInputBoxTheme.lightUserInputBoxTheme,
    scaffoldBackgroundColor: AppColors.kBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.kPaleGoldenrod,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.kBackground,
      ),
      iconTheme: IconThemeData(color: AppColors.kDarkGreen), // Dark green
    ),
  );
}
