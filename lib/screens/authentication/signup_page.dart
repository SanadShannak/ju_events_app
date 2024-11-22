import 'package:flutter/material.dart';
import 'package:temp_project/screens/authentication/components/background.dart';
import 'package:temp_project/screens/authentication/components/custom_primary_button.dart';
import 'package:temp_project/screens/authentication/components/custom_secondary_button.dart';
import 'package:temp_project/screens/authentication/components/custom_text_form_field.dart';
import 'package:temp_project/screens/authentication/components/footer.dart';
import 'package:temp_project/utilities/constants.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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

              // Sign Up Screen Components
              SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    // Top Padding
                    const SizedBox(
                      height: 50,
                    ),
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
                        "Sign Up",
                        style: TextStyle(
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
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextFormField(
                            hint: 'Enter Your Password',
                            passwordField: true,
                          ),
                        ),
                        // Repeat Your Password
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: CustomTextFormField(
                            hint: 'Repeat Your Password',
                            passwordField: true,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * 0.025),

                    // Sign Up Button
                    CustomPrimaryButton(
                      prompt: 'Sign Up',
                      onPressed: () {},
                    ),

                    // OR
                    Container(
                      height: size.height * 0.05,
                      alignment: Alignment.center,
                      child: const Text(
                        'OR',
                        style: TextStyle(
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

                    // Already Have An Account ? Sign In
                    Expanded(
                      child: FooterWidget(
                        leftText: "Already Have An Account ?",
                        rightClickableText: "Sign In",
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
