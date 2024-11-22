import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class UserInputBoxTheme {
  static InputDecorationTheme lightUserInputBoxTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 12),
    border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.kDarkGreen, width: .8),
        borderRadius: BorderRadius.circular(10.0)),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors
            .kForestGreen, // Change this to the desired focus border color
        width: 1.2, // Border width when focused
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    hintStyle: const TextStyle(
      color: Color(0xffA9A9A9),
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    prefixIconColor: AppColors.kDarkGreen,
    suffixIconColor: AppColors.kDarkGreen.withOpacity(0.75),
  );
}
