import 'package:flutter/material.dart';
import 'package:temp_project/screens/authentication/components/background.dart';
import 'package:temp_project/screens/authentication/components/background_top.dart';
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
              const TopBackgroundVectorShape(),
              const BackgroundVectorShape(),

              // Sign Up Screen Components
              SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
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
                    SizedBox(
                      height: size.height * 0.05,
                    ),

                    // Sign Up
                    Container(
                      width: size.width * 0.9,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.kDarkGreen),
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
                              formType: FormType.emailAddress,
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          // Enter Your Password
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CustomTextFormField(
                              hint: 'Enter Your Password',
                              validator: Validators.password,
                              controller: _passwordController,
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              formType: FormType.password,
                            ),
                          ),
                          // Repeat Your Password
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomTextFormField(
                              hint: 'Repeat Your Password',
                              controller: _confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                } else if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              autoValidateMode: AutovalidateMode.disabled,
                              formType: FormType.password,
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

                          Navigator.pushNamedAndRemoveUntil(context, '/greetingPage', (Route<dynamic> route) => false);
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
                        rightTextOnPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
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
