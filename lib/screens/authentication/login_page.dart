import 'package:flutter/material.dart';
import 'package:temp_project/screens/authentication/components/background.dart';
import 'package:temp_project/screens/authentication/components/background_top.dart';
import 'package:temp_project/screens/authentication/components/custom_primary_button.dart';
import 'package:temp_project/screens/authentication/components/custom_secondary_button.dart';
import 'package:temp_project/screens/authentication/components/footer.dart';
import 'package:temp_project/screens/authentication/forgot_password_page.dart';
import 'package:temp_project/utilities/constants.dart';
import 'package:temp_project/widgets/custom_text_form_field.dart';

import '../../services/auth_service.dart';
import '../../utilities/validators.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

              // Login Screen Components

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
                    // Sign In
                    Container(
                      width: size.width * 0.88,
                      alignment: Alignment.centerLeft,
                      child: const Text("Sign In",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kDarkGreen)),
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
                            ),
                          ),
                          // Enter Your Password
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomTextFormField(
                              hint: 'Enter Your Password',
                              validator: Validators.password,
                              controller: _passwordController,
                              formType: FormType.password,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Forgot Password?
                    SizedBox(
                      width: size.width * 0.9,
                      height: size.height * 0.05,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage(
                                        sourcePage: 'Login Page')));
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColors.kDarkGreen),
                          ),
                        ),
                      ),
                    ),

                    // Sign In Button
                    CustomPrimaryButton(
                      prompt: 'Sign In',
                      onPressed: () {
                        // validation
                        if (_formKey.currentState!.validate()) {
                          // validation
                          if (_formKey.currentState!.validate()) {
                            AuthService.instance
                                .signIn(
                                    email: _emailController.text,
                                    password: _passwordController.text)
                                .then((errorMessage) {
                              if (errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errorMessage)),
                                );
                              } else {
                                Navigator.pushReplacementNamed(context,
                                    '/mainPages'); //TODO: Change this if needed
                              }
                            });
                          }
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

                    // Don't Have An Account ? Sign Up
                    Expanded(
                      child: FooterWidget(
                        leftText: "Don't Have An Account ?",
                        rightClickableText: "Sign Up",
                        rightTextOnPressed: () {
                          Navigator.pushReplacementNamed(context, '/signup');
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
