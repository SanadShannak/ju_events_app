import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_project/utilities/constants.dart';

import '../../events/events_page.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(6, (index) {
          DateTime date = currentDate.add(Duration(days: index - 2));
          bool isSelected = date.day == currentDate.day;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventsPage.filteredByDate(
                            showBackButton: true,
                            dateTime: date,
                          )));
            },
            child: Container(
              // Container Details
              width: isSelected ? 63 : 53,
              height: isSelected ? 110 : 90,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.kPaleGoldenrod
                    : AppColors.kPaleGoldenrod.withAlpha(153),
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
                          isSelected ? FontWeight.w700 : FontWeight.w500,
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
            ),
          );
        }),
      ),
    );
  }
}
