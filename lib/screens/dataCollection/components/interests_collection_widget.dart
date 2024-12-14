import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class InterestsCollectionWidget extends StatefulWidget {
  final List<String> interestsList;
  final int maxNumberSelected;
  InterestsCollectionWidget(
      {super.key,
      required this.interestsList,
      required this.maxNumberSelected});

  @override
  State<InterestsCollectionWidget> createState() =>
      _InterestsCollectionWidgetState();
}

final Set<int> selectedInterests = {};

class _InterestsCollectionWidgetState extends State<InterestsCollectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: [
        ...List.generate(widget.interestsList.length, (selectedInterestIndex) {
          final isSelected = selectedInterests.contains(selectedInterestIndex);
          return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedInterests.remove(selectedInterestIndex); // Deselect
                  } else {
                    selectedInterests.add(selectedInterestIndex); // Select
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.kFernGreen.withOpacity(.90)
                      : AppColors.kDarkGreen.withOpacity(.90),
                  borderRadius: BorderRadius.circular(100.0),
                  border: Border.all(
                      color: isSelected
                          ? AppColors.kFernGreen
                          : AppColors.kDarkGreen,
                      width: 3),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                margin: const EdgeInsets.only(
                    left: 4, right: 4, top: 10, bottom: 10),
                child: Text(
                  widget.interestsList[selectedInterestIndex],
                  style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ));
        })
      ],
    );
  }
}
