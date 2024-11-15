import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

class LoggingButton extends StatelessWidget {
  const LoggingButton(
      {super.key,
      required this.child,
      this.widthPercentage = 0.75,
      this.heightPercentage = 0.05,
      this.onPressed,
      this.color = AppColors.kDarkGreen});

  final Widget child;
  final double widthPercentage;
  final double heightPercentage;
  final void Function()? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Container(
        width: size.width * widthPercentage,
        height: size.height * heightPercentage,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
