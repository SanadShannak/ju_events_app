import 'package:flutter/material.dart';
import 'package:ju_events_app/utilities/constants.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: const Text.rich(
          TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                  color: Constants.lightYellow, //
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                      color: Colors.white, //
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white), //
                )
              ]),
        ));
  }
}
