import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
    required this.leftText,
    required this.rightClicableText,
    required this.rightTextOnPressed,
  });

  final String leftText;
  final String rightClicableText;
  final void Function() rightTextOnPressed;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            leftText,
            style: TextStyle(
                color: (orientation == Orientation.portrait)
                    ? AppColors.kPaleGoldenrod
                    : AppColors.kDarkGreen, //
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400),
          ),
          TextButton(
              onPressed: rightTextOnPressed,
              child: Text(
                rightClicableText,
                style: TextStyle(
                    color: (orientation == Orientation.portrait)
                        ? AppColors.kBackground
                        : AppColors.kForestGreen,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white),
              ))
        ],
      ),
    );
  }
}
