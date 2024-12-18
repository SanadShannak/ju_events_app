import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../utilities/constants.dart';
import 'components/calendar_widget.dart';
import 'components/event_card.dart';
import 'components/institutional_unit_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<int, List> eventsList = {
      0: [
        'lib/assets/images/event_card_images/ai-workshop.jpeg',
        'AI Workshop',
        '25/12/2024',
        'Tech Hall'
      ],
      1: [
        'lib/assets/images/event_card_images/iot-seminar.jpeg',
        'Internet of Things Seminar',
        '30/12/2024',
        'Innovation Center'
      ],
      2: [
        'lib/assets/images/event_card_images/data-science-talk.jpeg',
        'Data Science Talk',
        '05/01/2025',
        'Main Auditorium'
      ],
      3: [
        'lib/assets/images/event_card_images/cybersecurity-expo.jpeg',
        'Cybersecurity Expo',
        '10/01/2025',
        'Tech Park'
      ],
    };
    Map<int, List> collegeList = {
      0: [
        'KASIT School',
        'lib/assets/images/college_card_images/kasit-school.jpg'
      ],
      1: [
        'Engineering School',
        'lib/assets/images/college_card_images/engineering-school.jpg'
      ],
      2: [
        'Languages School',
        'lib/assets/images/college_card_images/languages-school.jpg'
      ],
      3: [
        'Business School',
        'lib/assets/images/college_card_images/business-school.jpg'
      ],
      4: [
        'Medicine School',
        'lib/assets/images/college_card_images/medicine-school.jpg'
      ],
      5: [
        'Deanship of Student Affairs',
        'lib/assets/images/college_card_images/deanship-of-student-affairs.jpg'
      ],
    };
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              // top text
              Container(
                width: size.width * 0.9,
                height: size.height * 0.05,
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.center, // Optional, centers the text
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Events that might interest ',
                        style: TextStyle(
                          fontSize: 23, // Adjust font size
                          fontWeight: FontWeight.w600,
                          color: AppColors.kDarkGreen, // Set color
                        ),
                      ),
                      TextSpan(
                        text: 'you',
                        style: TextStyle(
                          fontSize: 23, // Adjust font size
                          color: AppColors.kForestGreen, // Set color
                          fontWeight: FontWeight.w600, // Bold for emphasis
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              // Event Cards
              Container(
                height: size.width * .59,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: index == 0
                          ? const EdgeInsets.only(
                              top: 14.0, bottom: 14.0, left: 35)
                          : (index == eventsList.length - 1
                              ? const EdgeInsets.only(
                                  top: 14.0, bottom: 14.0, right: 35)
                              : const EdgeInsets.symmetric(vertical: 14.0)),
                      child: EventCard(
                          backgroundImage: eventsList[index]?[0],
                          eventTitle: eventsList[index]?[1],
                          eventDate: eventsList[index]?[2],
                          eventLocation: eventsList[index]?[3]),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: size.width * .05,
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              // Event Dates text
              Container(
                  width: size.width * 0.9,
                  height: size.height * 0.05,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Event Dates',
                    style: TextStyle(
                      fontSize: 23, // Adjust font size
                      fontWeight: FontWeight.w600,
                      color: AppColors.kDarkGreen, // Set color
                    ),
                  )),
              // Calendar Widget
              Container(width: size.width * .95, child: const CalendarWidget()),
              const SizedBox(
                height: 20,
              ),
              // Colleges text
              Container(
                  width: size.width * 0.9,
                  height: size.height * 0.05,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Colleges',
                    style: TextStyle(
                      fontSize: 23, // Adjust font size
                      fontWeight: FontWeight.w600,
                      color: AppColors.kDarkGreen, // Set color
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              // Colleges cards
              Container(
                width: size.width * .9,
                child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    spacing: 20.0,
                    runSpacing: 36.0,
                    children: [
                      ...List.generate(collegeList.length, (index) {
                        return InstitutionalUnitCard(
                            name: collegeList[index]?[0],
                            imagePath: collegeList[index]?[1]);
                      })
                    ]),
              ),
              SizedBox(
                // TODO: Delete this (ADDED FOR TESTING PURPOSES ONLY)
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
