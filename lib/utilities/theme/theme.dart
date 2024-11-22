import 'package:flutter/material.dart';

import 'package:temp_project/utilities/theme/widget_themes/user_input_box_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    inputDecorationTheme: UserInputBoxTheme.lightUserInputBoxTheme,
  );
}
