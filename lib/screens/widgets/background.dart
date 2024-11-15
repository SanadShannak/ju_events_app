import 'package:flutter/material.dart';

class LoggingBackground extends StatelessWidget {
  const LoggingBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/images/background_effects/crop_square.png',
            width: double.infinity,
            height: size.height,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child
      ],
    );
  }
}
