import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_project/screens/homePage/components/event_desciption_text.dart';

import 'package:temp_project/utilities/constants.dart';

class EventDetails extends StatelessWidget {
  final List? eventDataList;

  const EventDetails({super.key, required this.eventDataList});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String eventBackgroundImagePath = eventDataList?[0];
    String eventTitle = eventDataList?[1];
    String eventDateString = eventDataList?[2];
    String eventStartEndTimeString = eventDataList?[3];
    String eventLocation = eventDataList?[4];
    String eventSubLocation = eventDataList?[5];
    String eventDescription = eventDataList?[6];
    String eventHostName = eventDataList?[7];
    DateTime eventDate = DateFormat("dd/MM/yyyy").parse(eventDateString);
    String eventDayName = DateFormat('EEEE').format(eventDate);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------------------ Background Image ------------------------------------------
            Container(
              height: size.height / 2.1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(eventBackgroundImagePath),
                      fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))),
              // Back Button
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 50),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.white,
                      backgroundColor: Colors.white.withOpacity(.9),
                      padding: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.kFernGreen,
                      size: 30,
                      shadows: [
                        Shadow(color: AppColors.kFernGreen, blurRadius: 2)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            // ------------------------------------------ Event Title ------------------------------------------
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: AutoSizeText(eventTitle,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kDarkGreen,
                  ),
                  minFontSize: 16,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(
              height: 5,
            ),
            // ------------------------------------------ Event Description ------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: EventDescriptionText(text: eventDescription),
            ),
            const SizedBox(
              height: 20,
            ),
            // ------------------------------------------ Event Date ------------------------------------------
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.kDarkGreen,
                    size: 50,
                  ),
                  // SPACE BETWEEN CALENDAR ICON AND TEXT
                  const SizedBox(
                    width: 15,
                  ),
                  // DATE TEXT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$eventDayName, $eventDateString',
                        style: const TextStyle(
                            color: AppColors.kDarkGreen,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        eventStartEndTimeString,
                        style: const TextStyle(
                            color: AppColors.kForestGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // ------------------------------------------ Event Location ------------------------------------------
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: AppColors.kDarkGreen,
                    size: 50,
                  ),
                  // SPACE BETWEEN LOCATION ICON AND TEXT
                  const SizedBox(
                    width: 15,
                  ),
                  // LOCATION TEXT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          eventLocation,
                          minFontSize: 12,
                          maxLines: 2,
                          style: const TextStyle(
                              color: AppColors.kDarkGreen,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          eventSubLocation,
                          style: const TextStyle(
                              color: AppColors.kForestGreen,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // ------------------------------------------ Event Host ------------------------------------------
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.groups,
                    color: AppColors.kDarkGreen,
                    size: 50,
                  ),
                  // SPACE BETWEEN ICON AND TEXT
                  const SizedBox(
                    width: 15,
                  ),
                  // LOCATION TEXT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hosted by',
                        style: TextStyle(
                            color: AppColors.kDarkGreen,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        eventHostName,
                        style: const TextStyle(
                            color: AppColors.kForestGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
