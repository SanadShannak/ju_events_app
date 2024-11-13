import 'package:flutter/material.dart';
import 'package:ju_events_app/utilities/constants.dart';

class SignInHeading extends StatelessWidget {
  const SignInHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sign In",
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Constants.darkGreen),
        ),
      ],
    );
  }
}
