import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget titleWidget;
  final bool? showBackButton;
  @override
  final Size preferredSize; // Required to implement PreferredSizeWidget

  const CustomAppBar(
      {super.key, required this.titleWidget, this.showBackButton = false})
      : preferredSize = const Size.fromHeight(65.0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: showBackButton == true ? 17.0 : 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showBackButton == true)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.kDarkGreen),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            Container(
                height: preferredSize.height,
                width:
                    showBackButton == true ? size.width * .78 : size.width * .9,
                decoration: BoxDecoration(
                  color: AppColors.kPaleGoldenrod,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0), // Inner padding
                child: titleWidget),
          ],
        ),
      ),
    );
  }
}
