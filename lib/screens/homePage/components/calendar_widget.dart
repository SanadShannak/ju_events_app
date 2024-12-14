import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_project/utilities/constants.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(6, (index) {
              DateTime date = currentDate.add(Duration(days: index - 2));
              bool isSelected = date.day == currentDate.day;

              return Container(
                // Container Details
                width: isSelected ? 65 : 55,
                height: isSelected ? 110 : 90,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.kPaleGoldenrod
                      : AppColors.kPaleGoldenrod.withOpacity(.6),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Day Text
                    Text(
                      DateFormat('EEE')
                          .format(date)
                          .substring(0, 2)
                          .toUpperCase(), // Day abbreviation (MO, TU, etc.)
                      style: TextStyle(
                        color: AppColors.kForestGreen,
                        fontSize: isSelected ? 18 : 14,
                        fontWeight:
                            isSelected ? FontWeight.w900 : FontWeight.bold,
                      ),
                    ),
                    // Space between Day and Date
                    const SizedBox(
                      height: 5,
                    ),
                    // DATE Number
                    Text(
                      date.day.toString(), // Day number
                      style: TextStyle(
                        color: AppColors.kForestGreen,
                        fontSize: isSelected ? 18 : 14,
                        fontWeight:
                            isSelected ? FontWeight.w900 : FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
