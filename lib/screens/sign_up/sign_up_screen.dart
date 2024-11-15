import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ju_events_app/screens/components/logging_text_field.dart';
import 'package:ju_events_app/screens/widgets/background.dart';

import '../../utilities/constants.dart';
import '../components/logging_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return LoggingBackground(
        child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // JU Logo
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/logos/JU_logo.png',
                height: size.height * 0.2,
                alignment: Alignment.center,
              ),
            ),

            // Sign Up
            Container(
              alignment: Alignment.centerLeft,
              width: size.width * 0.9,
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: AppColors.kDarkGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                ),
              ),
            ),

            // Enter your email TextFormField
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  LoggingTextFormField(
                    hint: 'Enter Your Email',
                  ),
                  // Enter your Password TextFormField
                  LoggingTextFormField(
                    hint: 'Enter Your Password',
                    passwordField: true,
                  ),
                  // Repeat your Password TextFormField
                  LoggingTextFormField(
                    hint: 'Repeat Your Password',
                    passwordField: true,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Sign Up Button
                  const LoggingButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // OR
                  const Text(
                    'OR',
                    style: TextStyle(
                      color: AppColors.kHintTextColor,
                      fontSize: 16,
                    ),
                  ),

                  // Continue With Google
                  const LoggingButton(
                      widthPercentage: 0.75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Continue With Google',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),

                  // Continue With LinkedIn and FaceBook
                  SizedBox(
                    width: size.width * 0.75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: LoggingButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.g_translate,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Linkedin',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        const Expanded(
                          child: LoggingButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.g_translate,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Facebook',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            // Already have an account? Sign In
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: AppColors.kPaleGoldenrod,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    child: const Text(
                      'Sign In ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.kBackground,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.kBackground,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
