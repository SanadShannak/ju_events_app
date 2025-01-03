import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class EventDescriptionText extends StatefulWidget {
  final String text;
  const EventDescriptionText({super.key, required this.text});

  @override
  State<EventDescriptionText> createState() => _EventDescriptionTextState();
}

class _EventDescriptionTextState extends State<EventDescriptionText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    const int maxLength = 150;
    String displayText = widget.text;

    if (widget.text.length > maxLength && !isExpanded) {
      displayText = '${widget.text.substring(0, maxLength)}...';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ----------------------------------- 'Description' Text: uncomment to use -----------------------------------
//        const Align(
//          alignment: Alignment.topLeft,
//          child: Text(
//            'Description',
//          ),
//        ),
//        SizedBox(
//          height: 5,
//        ),
        // ------------------------------------------ Description ------------------------------------------
        Text(
          displayText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.kDarkGreen.withAlpha(230),
          ),
        ),
        // ------------------------------------------ 'Read More' button ------------------------------------------
        if (widget.text.length > maxLength)
          const SizedBox(
            height: 10,
          ),
        if (widget.text.length > maxLength)
          TextButton(
            style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.kPaleGoldenrod)),
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Read Less' : 'Read More',
              style: const TextStyle(color: AppColors.kDarkGreen, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
