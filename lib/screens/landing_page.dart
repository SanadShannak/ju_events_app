import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'authentication/components/custom_primary_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              // welcome svg image
              Image.asset(
                'lib/assets/images/others/welcome.png',
                width: size.width * 0.7,
                height: size.height * 0.3,
              ),

              // welcome text
              Container(
                width: size.width * 0.7,
                height: size.height * 0.2,
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center, // Optional, centers the text
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Find Your Next Adventure on Campus with ',
                        style: TextStyle(
                          fontSize: 18, // Adjust font size
                          fontWeight: FontWeight.w500,
                          color: AppColors.kDarkGreen, // Set color
                        ),
                      ),
                      TextSpan(
                        text: 'JuEvents !',
                        style: TextStyle(
                          fontSize: 24, // Adjust font size
                          color: AppColors.kForestGreen, // Set color
                          fontWeight: FontWeight.w600, // Bold for emphasis
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Sign Up button
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomPrimaryButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  prompt: 'Sign Up',
                ),
              ),
              // Sign In button
              CustomPrimaryButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                prompt: 'Sign In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
