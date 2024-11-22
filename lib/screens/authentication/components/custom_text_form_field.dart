import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class CustomTextFormFieldContainer extends StatelessWidget {
  const CustomTextFormFieldContainer({super.key, required this.textFormField});
  final TextFormField textFormField;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: size.width * 0.9,
      child: textFormField,
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      required this.hint,
      this.controller,
      this.validator,
      this.passwordField});

  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? passwordField;

  @override
  State<CustomTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<CustomTextFormField> {
  bool obscureState = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormFieldContainer(
      textFormField: TextFormField(
        cursorColor: AppColors.kForestGreen,
        validator: widget.validator,
        controller: widget.controller,
        // decoration
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon:
              (widget.passwordField == null || widget.passwordField == false)
                  ? const Icon(
                      Icons.person,
                    )
                  : const Icon(
                      Icons.password,
                    ),
          // if passwordField true
          suffixIcon:
              (widget.passwordField == null || widget.passwordField == false)
                  ? null
                  : GestureDetector(
                      child: obscureState
                          ? const Icon(
                              Icons.visibility_off,
                            )
                          : const Icon(
                              Icons.visibility,
                            ),
                      onTap: () {
                        setState(() {
                          obscureState = !obscureState;
                        });
                      },
                    ),
        ),

        // if passwordField true
        obscureText:
            (widget.passwordField == null || widget.passwordField == false)
                ? false
                : obscureState,
      ),
    );
  }
}
