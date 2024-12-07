import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../utilities/constants.dart';

class InstitutionalUnitCard extends StatelessWidget {
  const InstitutionalUnitCard(
      {super.key, required this.name, required this.imagePath, this.width = 110, this.height = 110, this.onTap});

  final String name;
  final String imagePath;
  final void Function()? onTap;
  final double width;
  final double height;

  static const Radius borderRadius = Radius.circular(16);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.kDarkGreen.withOpacity(0.15), // Lighter shadow
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
            BoxShadow(
              color: AppColors.kDarkGreen.withOpacity(0.25), // Stronger shadow
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
          borderRadius: const BorderRadius.all(borderRadius),
          color: Colors.blueGrey,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(borderRadius),
          child: Stack(
            children: [
              Image.asset(imagePath, fit: BoxFit.cover, height: height, width: width,
                  errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: height, color: Colors.grey);
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(
                    maxHeight: height * 0.3,
                    maxWidth: width,
                  ),
                  height: height * 0.3,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.97),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: borderRadius,
                      bottomRight: borderRadius,
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: AutoSizeText(
                        name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.kDarkGreen),
                        minFontSize: 8,
                        maxFontSize: 10,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
