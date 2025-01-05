import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget titleWidget;
  @override
  final Size preferredSize; // Required to implement PreferredSizeWidget

  const CustomAppBar({super.key, required this.titleWidget})
      : preferredSize = const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
            height: preferredSize.height,
            decoration: BoxDecoration(
              color: AppColors.kPaleGoldenrod,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 12.0), // Inner padding
            child: titleWidget),
      ),
    );
  }
}
