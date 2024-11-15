import 'package:flutter/material.dart';
import 'package:ju_events_app/utilities/constants.dart';

class LoggingTextFormFieldContainer extends StatelessWidget {
  const LoggingTextFormFieldContainer({super.key, required this.textFormField});
  final TextFormField textFormField;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        width: size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff767171),
            width: 0.7,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: textFormField);
  }
}

class LoggingTextFormField extends StatefulWidget {
  const LoggingTextFormField({super.key, required this.hint, this.controller, this.validator, this.passwordField});
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? passwordField;

  @override
  State<LoggingTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<LoggingTextFormField> {
  bool obscureState = true;

  @override
  Widget build(BuildContext context) {
    return LoggingTextFormFieldContainer(
      textFormField: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        // decoration
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          hintText: widget.hint,
          border: InputBorder.none,
          hintStyle: const TextStyle(
            color: Color(0xffA9A9A9),
            fontSize: 14,
          ),
          prefixIcon: (widget.passwordField == null || widget.passwordField == false)
              ? const Icon(
                  Icons.person,
                  color: AppColors.kDarkGreen,
                )
              : const Icon(
                  Icons.password,
                  color: AppColors.kDarkGreen,
                ),
          // if passwordField true
          suffixIcon: (widget.passwordField == null || widget.passwordField == false)
              ? null
              : GestureDetector(
                  child: obscureState
                      ? const Opacity(
                          opacity: 0.75,
                          child: Icon(
                            Icons.visibility_off,
                            color: AppColors.kDarkGreen,
                          ),
                        )
                      : const Opacity(
                          opacity: 0.75,
                          child: Icon(
                            Icons.visibility,
                            color: AppColors.kDarkGreen,
                          ),
                        ),
                  onTap: () {
                    setState(() {
                      obscureState = !obscureState;
                    });
                  },
                ),
        ),

        // if passwordField true
        obscureText: (widget.passwordField == null || widget.passwordField == false) ? false : obscureState,
      ),
    );
  }
}
