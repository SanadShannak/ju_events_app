import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton(
      {super.key,
      required this.prompt,
      required this.onPressed,
      this.sizePercentage = 0.75});
  final String prompt;
  final void Function() onPressed;
  final double sizePercentage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.75,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.kDarkGreen.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kDarkGreen,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          prompt,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
