import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class EventCard extends StatelessWidget {
  final String backgroundImage;
  final String eventTitle;
  final String eventDate;
  final String eventLocation;

  const EventCard(
      {super.key,
      required this.backgroundImage,
      required this.eventTitle,
      required this.eventDate,
      required this.eventLocation});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double eventcardWidth = screenWidth * 0.73;
    double eventcardHeight = eventcardWidth * 0.6666;
    return Container(
      // MAIN CARD
      width: eventcardWidth,
      height: eventcardHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.blueGrey, // BACKGROUND COLOR IN CASE IMAGE FAILS
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: Stack(
        children: [
          // BACKGROUND IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(backgroundImage,
                height: eventcardHeight, width: eventcardWidth,
                errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.broken_image,
                size: eventcardWidth,
                color: Colors.grey,
              );
            }),
          ),
          //WHITE BOX
          Positioned(
            top: 145,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.90),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SPACE ABOVE TITLE
                  const SizedBox(
                    height: 7,
                  ),
                  // TITLE ROW
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      eventTitle,
                      style: TextStyle(
                          fontSize: 19,
                          color: AppColors.kDarkGreen,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  // DETAILS ROW
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      children: [
                        // SPACE BEFORE DATE

                        // CALENDAR ICON
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Image.asset(
                            'lib/assets/images/icons/calendar.png',
                            color: AppColors.kDarkGreen,
                            width: 15,
                            height: 15,
                          ),
                        ),
                        // SPACE BETWEEN CALENDAR ICON AND TEXT
                        const SizedBox(
                          width: 5,
                        ),
                        // DATE TEXT
                        Text(
                          eventDate,
                          style: TextStyle(
                              color: AppColors.kForestGreen,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                        // SPACE BETWEEN DATE AND LOCATION
                        const SizedBox(
                          width: 50,
                        ),
                        // LOCATION ICON
                        Image.asset(
                          'lib/assets/images/icons/location.png',
                          color: AppColors.kDarkGreen,
                          width: 15,
                          height: 15,
                        ),
                        // SPACE BETWEEN LOCATION ICON AND TEXT
                        const SizedBox(
                          width: 5,
                        ),
                        // LOCATION TEXT
                        Text(
                          eventLocation,
                          style: TextStyle(
                              color: AppColors.kForestGreen,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
