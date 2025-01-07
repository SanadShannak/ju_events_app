import 'package:flutter/material.dart';
import 'package:temp_project/screens/authentication/components/custom_primary_button.dart';
import 'package:temp_project/services/auth_service.dart';
import 'package:temp_project/utilities/constants.dart';
import 'package:temp_project/utilities/validators.dart';
import 'package:temp_project/widgets/custom_text_form_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  final String sourcePage;
  ForgotPasswordPage({super.key, required this.sourcePage});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final _auth = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    Future<void> _showSnackBar(String message, Color textColor) async {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1, milliseconds: 500),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w500, fontSize: 14),
          ),
          backgroundColor: Colors.grey[300],
        ),
      );
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * .15),
              const Icon(
                Icons.lock,
                size: 100,
                color: AppColors.kDarkGreen,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Forgot Your Password?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Don\'t worry, we will send you reset instructions.',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(right: 310),
                child: const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kDarkGreen,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: CustomTextFormField(
                  hint: 'Enter Your Email',
                  validator: Validators.email,
                  controller: _emailController,
                  formType: FormType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: size.width * .88,
                child: CustomPrimaryButton(
                    prompt: 'Reset Password',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(_emailController.text);
                        _auth.sendPasswordResetEmail(_emailController.text);
                        _showSnackBar(
                            'Reset instructions were send to your email!',
                            AppColors.kDarkGreen);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      }
                    }),
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.kForestGreen,
                  ),
                  label: Text(
                    'Back to $sourcePage ',
                    style: const TextStyle(
                        color: AppColors.kForestGreen, fontSize: 14),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
