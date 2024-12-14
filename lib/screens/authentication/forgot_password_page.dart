import 'package:flutter/material.dart';
import 'package:temp_project/screens/authentication/components/custom_primary_button.dart';
import 'package:temp_project/screens/authentication/components/custom_text_form_field.dart';
import 'package:temp_project/utilities/constants.dart';
import 'package:temp_project/utilities/validators.dart';

class ForgotPasswordPage extends StatelessWidget {
  final String sourcePage;
  ForgotPasswordPage({super.key, required this.sourcePage});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        // collect data
                        print(
                            '${_emailController.text}  || Email || collected');
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
