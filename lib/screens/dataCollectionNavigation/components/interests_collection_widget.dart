import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp_project/providers/data_collection_provider.dart';
import 'package:temp_project/utilities/constants.dart';

class InterestsCollectionWidget<T> extends StatefulWidget {
  final List<String> interestsList;
  final int maxNumberSelected;
  final void Function(T provider, String interest) addInterest;
  final void Function(T provider, String interest) removeInterest;

  const InterestsCollectionWidget({
    super.key,
    required this.interestsList,
    required this.maxNumberSelected,
    required this.addInterest,
    required this.removeInterest,
  });

  @override
  State<InterestsCollectionWidget<T>> createState() =>
      _InterestsCollectionWidgetState<T>();
}

class _InterestsCollectionWidgetState<T>
    extends State<InterestsCollectionWidget<T>> {
  @override
  Widget build(BuildContext context) {
    final dataCollectionProvider = context.watch<DataCollectionProvider>();
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: [
        ...List.generate(widget.interestsList.length, (selectedInterestIndex) {
          final isSelected = dataCollectionProvider.selectedInterestIndices
              .contains(selectedInterestIndex);
          return GestureDetector(
              onTap: () {
                setState(() {
                  final provider = context.read<T>();
                  if (isSelected) {
                    dataCollectionProvider.selectedInterestIndices
                        .remove(selectedInterestIndex);
                    widget.removeInterest(
                        provider, widget.interestsList[selectedInterestIndex]);
                  } else {
                    dataCollectionProvider.selectedInterestIndices
                        .add(selectedInterestIndex);
                    widget.addInterest(
                        provider, widget.interestsList[selectedInterestIndex]);
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
