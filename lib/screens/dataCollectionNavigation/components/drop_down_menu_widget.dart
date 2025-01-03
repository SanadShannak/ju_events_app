import 'package:flutter/material.dart';

import 'package:temp_project/utilities/constants.dart';

class CustomDropDownMenuWidget extends StatefulWidget {
  final GlobalKey<FormFieldState> dropDownMenuKey;
  final String formLabel;
  final List<DropdownMenuItem<String>> dropDownMenuEntries;
  final String? dropDownMenuValue;
  final Function(String?)? dropDownMenuOnChanged;
  final String? Function(String?)? dropDownMenuValidator;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  const CustomDropDownMenuWidget({
    super.key,
    required this.dropDownMenuKey,
    required this.dropDownMenuEntries,
    required this.dropDownMenuValue,
    required this.dropDownMenuOnChanged,
    required this.dropDownMenuValidator,
    required this.selectedItemBuilder,
    required this.formLabel,
  });

  @override
  State<CustomDropDownMenuWidget> createState() =>
      _CustomDropDownMenuWidgetState();
}

class _CustomDropDownMenuWidgetState extends State<CustomDropDownMenuWidget> {
  List<String> colleges = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DropdownButtonFormField<String>(
      key: widget.dropDownMenuKey,
      value: widget.dropDownMenuValue,
      dropdownColor: Colors.white,
      iconEnabledColor: AppColors.kDarkGreen,
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
