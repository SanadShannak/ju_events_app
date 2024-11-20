import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class CustomSecondaryButton extends StatelessWidget {
  const CustomSecondaryButton(
      {super.key, required this.prompt, required this.onPressed, this.prefix, this.sizePercentage = 0.75});
  final Widget? prefix;
  final String prompt;
  final void Function() onPressed;
  final double sizePercentage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * sizePercentage,

      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3))
      ]),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Prefix
            prefix == null ? const SizedBox.shrink() : prefix!,
            // Separator 
            const SizedBox(
              width: 10,
            ),
            // Prompt Text
            Text(
              prompt,
              style: const TextStyle(
                  fontFamily: 'Roboto',
                  color: AppColors.kDarkGreen,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
