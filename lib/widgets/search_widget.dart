import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.widthRatio,
    this.onChange,
  });

  final double widthRatio;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        width: size.width * widthRatio, // Fixed width for the search bar
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.kPaleGoldenrod, // Slightly darker yellow
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: onChange,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Search",
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  hintStyle: TextStyle(color: AppColors.kForestGreen),
                ),
                style: const TextStyle(
                  color: AppColors.kDarkGreen, // Dark green color
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.search,
                color: AppColors.kForestGreen, // Dark green color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
