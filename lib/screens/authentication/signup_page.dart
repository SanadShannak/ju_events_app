import 'package:flutter/material.dart';
import 'package:temp_project/screens/authentication/components/background.dart';
import 'package:temp_project/screens/authentication/components/custom_primary_button.dart';
import 'package:temp_project/screens/authentication/components/custom_secondary_button.dart';
import 'package:temp_project/screens/authentication/components/custom_text_form_field.dart';
import 'package:temp_project/screens/authentication/components/footer.dart';
import 'package:temp_project/utilities/constants.dart';

import '../../utilities/validators.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
                            fontFamily: 'Roboto',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kDarkGreen),
                      ),
                    ),
                    // Text Form Fields
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Enter Your Email
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CustomTextFormField(
                              hint: 'Enter Your Email',
                              validator: Validators.email,
                              controller: _emailController,
                            ),
                          ),
                          // Enter Your Password
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CustomTextFormField(
                              hint: 'Enter Your Password',
                              passwordField: true,
                              validator: Validators.password,
                              controller: _passwordController,
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          // Repeat Your Password
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomTextFormField(
                              hint: 'Repeat Your Password',
                              passwordField: true,
                              controller: _confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                } else if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: size.height * 0.025),

                    // Sign Up Button
                    CustomPrimaryButton(
                      prompt: 'Sign Up',
                      onPressed: () {
                        // validation
                        if (_formKey.currentState!.validate()) {
                          // collect data
                          print('${_emailController.text}  || Email || collected');
                          print('${_passwordController.text}  || Password || collected');
                          print('${_confirmPasswordController.text}  || Confirm Password || collected');
                        }
                      },
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

                    // Already Have An Account ? Sign In
                    Expanded(
                      child: FooterWidget(
                        leftText: "Already Have An Account ?",
                        rightClicableText: "Sign In",
                        rightTextOnPressed: () {
                          Navigator.pushReplacementNamed(context, '/');
                        },
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
