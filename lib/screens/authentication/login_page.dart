import 'package:flutter/material.dart';
import 'package:temp_project/screens/authentication/components/background.dart';
import 'package:temp_project/screens/authentication/components/custom_primary_button.dart';
import 'package:temp_project/screens/authentication/components/custom_secondary_button.dart';
import 'package:temp_project/screens/authentication/components/custom_text_form_field.dart';
import 'package:temp_project/screens/authentication/components/footer.dart';
import 'package:temp_project/utilities/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Background Widget
              const BackgroundVectorShape(),

              // Login Screen Components
              SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    // JU Logo
                    SizedBox(
                      width: size.width,
                      child: Image.asset(
                        'lib/assets/images/logos/JU_logo.png',
                        height: size.height * 0.2,
                        alignment: Alignment.center,
                      ),
                    ),

                    // Sign In
                    Container(
                      width: size.width * 0.9,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kDarkGreen),
                      ),
                    ),

                    // Text Form Fields
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Enter Your Email
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextFormField(hint: 'Enter Your Email'),
                        ),
                        // Enter Your Password
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: CustomTextFormField(
                            hint: 'Enter Your Password',
                            passwordField: true,
                          ),
                        ),
                      ],
                    ),

                    // Forgot Password?
                    SizedBox(
                      width: size.width * 0.9,
                      height: size.height * 0.05,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.kDarkGreen),
                          ),
                        ),
                      ),
                    ),

                    // Sign In Button
                    CustomPrimaryButton(
                      prompt: 'Sign In',
                      onPressed: () {},
                    ),

                    // OR
                    Container(
                      height: size.height * 0.05,
                      alignment: Alignment.center,
                      child: const Text(
                        'OR',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColors.kPlaceHolderGrey,
                        ),
                      ),
                    ),

                    // Continue With Google Button
                    CustomSecondaryButton(
                      onPressed: () {},
                      prompt: 'Continue With Google',
                      prefix: Image.asset(
                        'lib/assets/images/logos/google_logo.png',
                        width: 30,
                        height: 30,
                      ),
                    ),

                    const Spacer(),

                    // Don't Have An Account ? Sign Up
                    Expanded(
                      child: FooterWidget(
                        leftText: "Don't Have An Account ?",
                        rightClicableText: "Sign Up",
                        rightTextOnPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
