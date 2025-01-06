import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temp_project/utilities/constants.dart';

enum FormType {
  password(
    keyboardType: TextInputType.text,
    firstSuffixIcon: Icon(Icons.visibility_off),
    secondSuffixIcon: Icon(Icons.visibility),
    prefixIcon: Icon(Icons.password),
    changeObscurityOnSuffixTap: true,
    enableInteractiveSelection: false,
  ),
  emailAddress(
    keyboardType: TextInputType.emailAddress,
    prefixIcon: Icon(Icons.email),
  ),
  userName(
    keyboardType: TextInputType.name,
  ),
  normalUse(
    keyboardType: TextInputType.text,
  );

  const FormType(
      {this.keyboardType = TextInputType.text,
      this.prefixIcon,
      this.firstSuffixIcon,
      this.secondSuffixIcon,
      this.changeObscurityOnSuffixTap = false,
      this.enableInteractiveSelection = true});

  final TextInputType keyboardType;
  final Icon? prefixIcon;
  final Icon? firstSuffixIcon;
  final Icon? secondSuffixIcon;
  final bool changeObscurityOnSuffixTap;
  final bool enableInteractiveSelection;
}

class CustomTextFormFieldContainer extends StatelessWidget {
  const CustomTextFormFieldContainer({super.key, required this.textFormField, required this.screenWidthRatio});
  final TextFormField textFormField;
  final double screenWidthRatio;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(5),
      width: size.width * screenWidthRatio,
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
      this.autoValidateMode,
      required this.formType,
      this.screenWidthRatio = 0.9,
      this.onTextChange,
      this.lettersAndSpacesOnly = false});

  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FormType formType;
  final AutovalidateMode? autoValidateMode;
  final double screenWidthRatio;
  final void Function(String)? onTextChange;
  final bool lettersAndSpacesOnly;

  @override
  State<CustomTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<CustomTextFormField> {
  bool suffixIconState = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormFieldContainer(
      screenWidthRatio: widget.screenWidthRatio,
      textFormField: TextFormField(
        cursorColor: AppColors.kForestGreen,
        autovalidateMode: widget.autoValidateMode,
        validator: widget.validator,
        controller: widget.controller,
        onChanged: widget.onTextChange,
        inputFormatters: widget.lettersAndSpacesOnly
            ? [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-Z\s]'),
                )
              ]
            : null,

        // keyboard input type
        keyboardType: widget.formType.keyboardType,

        // decoration
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: widget.formType.prefixIcon,
          contentPadding: widget.formType.prefixIcon == null ? const EdgeInsets.only(left: 20) : null,
          // Suffix Icon
          suffixIcon: widget.formType.secondSuffixIcon == null
              ? widget.formType.firstSuffixIcon
              : GestureDetector(
                  child: suffixIconState ? widget.formType.firstSuffixIcon : widget.formType.secondSuffixIcon,
                  onLongPress: () => setState(() {
                    suffixIconState = !suffixIconState;
                  }),
                  onLongPressEnd: (details) => setState(() {
                    suffixIconState = !suffixIconState;
                  }),
                ),
        ),
        enableInteractiveSelection: widget.formType.enableInteractiveSelection,
        obscureText: widget.formType.changeObscurityOnSuffixTap ? suffixIconState : false,
      ),
    );
  }
}
