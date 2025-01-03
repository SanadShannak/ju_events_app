import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_project/screens/homePage/components/event_description_text.dart';
import 'package:temp_project/utilities/constants.dart';
import 'package:temp_project/utilities/testing_random_image_generator.dart';

import '../../../models/event.dart';

class EventDetails extends StatelessWidget {
  final Event event;
  final String? imagePath;

  const EventDetails({super.key, required this.event, this.imagePath});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                      image: AssetImage(imagePath ??
                          'lib/assets/images/event_card_images_by_index/${RandomImageGenerator.getRandomEventImagePath()}'),
                      fit: BoxFit.cover),
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0))),
              // Back Button
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 50),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.white,
                      backgroundColor: Colors.white.withValues(alpha: 230),
                      padding: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.kFernGreen,
                      size: 30,
                      shadows: [Shadow(color: AppColors.kFernGreen, blurRadius: 2)],
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
              child: AutoSizeText(event.name,
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
              child: EventDescriptionText(text: event.description),
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
                        '${DateFormat('EEE').format(event.dateTime)}, ${DateFormat('dd-MM-yyyy').format(event.dateTime)}',
                        style: const TextStyle(color: AppColors.kDarkGreen, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(event.dateTime),
                        style:
                            const TextStyle(color: AppColors.kForestGreen, fontSize: 12, fontWeight: FontWeight.w500),
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
                          event.locationInfo,
                          minFontSize: 12,
                          maxLines: 2,
                          style:
                              const TextStyle(color: AppColors.kDarkGreen, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          event.subLocationInfo,
                          style:
                              const TextStyle(color: AppColors.kForestGreen, fontSize: 12, fontWeight: FontWeight.w500),
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
                        style: TextStyle(color: AppColors.kDarkGreen, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        event.postedByName,
                        style:
                            const TextStyle(color: AppColors.kForestGreen, fontSize: 12, fontWeight: FontWeight.w500),
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
  }
}
