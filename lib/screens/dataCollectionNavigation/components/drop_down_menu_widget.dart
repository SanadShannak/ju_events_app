import 'package:flutter/material.dart';

import 'package:temp_project/utilities/constants.dart';

class CustomDropDownMenuWidget extends StatefulWidget {
  final GlobalKey<FormFieldState> dropDownMenuKey;
  final String? formLabel;
  final List<DropdownMenuItem<String>> dropDownMenuEntries;
  final String? dropDownMenuValue;
  final Function(String?)? dropDownMenuOnChanged;
  final String? Function(String?)? dropDownMenuValidator;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final String? formHint;

  const CustomDropDownMenuWidget({
    super.key,
    required this.dropDownMenuKey,
    required this.dropDownMenuEntries,
    required this.dropDownMenuValue,
    required this.dropDownMenuOnChanged,
    required this.dropDownMenuValidator,
    required this.selectedItemBuilder,
    this.formLabel,
    this.formHint,
  });

  @override
  State<CustomDropDownMenuWidget> createState() =>
      _CustomDropDownMenuWidgetState();
}

class _CustomDropDownMenuWidgetState extends State<CustomDropDownMenuWidget> {
  List<String> colleges = [];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      key: widget.dropDownMenuKey,
      value: widget.dropDownMenuValue,
      dropdownColor: Colors.white,
      iconEnabledColor: AppColors.kDarkGreen,
      hint: widget.formHint != null
          ? Text(
              widget.formHint!,
              style: const TextStyle(
                color: AppColors.kHintTextColor,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      menuMaxHeight: 300.0,
      decoration: InputDecoration(
        labelText: widget.formLabel,
        labelStyle: const TextStyle(
          color: AppColors.kDarkGreen,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            borderSide: BorderSide(color: AppColors.kDarkGreen)),
        contentPadding: const EdgeInsets.all(16.0),
      ),
      items: widget.dropDownMenuEntries,
      selectedItemBuilder: widget.selectedItemBuilder,
      onChanged: widget.dropDownMenuOnChanged,
      validator: widget.dropDownMenuValidator,
    );
  }
}
