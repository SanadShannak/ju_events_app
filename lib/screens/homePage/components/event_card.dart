import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class EventCard extends StatelessWidget {
  final String backgroundImage;
  final String eventTitle;
  final String eventDate;
  final String eventLocation;
  final void Function()? onTap;

  const EventCard(
      {super.key,
      required this.backgroundImage,
      required this.eventTitle,
      required this.eventDate,
      required this.eventLocation,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double eventCardWidth = screenWidth * 0.73;
    double eventCardHeight = eventCardWidth * 0.6666;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //-------------------------------------------- Container Properties -----------------------------------
        width: eventCardWidth,
        height: eventCardHeight,
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

        //-------------------------------------------- Container Child ---------------------------------------
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: [
              //------------------------------------- Background Image ---------------------------------------
              Image.asset(backgroundImage,
                  height: eventCardHeight,
                  width: eventCardWidth,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.broken_image,
                  size: eventCardWidth,
                  color: Colors.grey,
                );
              }),
              //------------------------------------- Information Box  ---------------------------------------
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: eventCardHeight * 0.3,
                    maxWidth: eventCardWidth,
                  ),
                  height: eventCardHeight * 0.3,
                  width: eventCardWidth,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.90),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // TITLE ROW
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 10, top: 3),
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: eventCardHeight * 0.17,
                            maxWidth: eventCardWidth,
                          ),
                          height: eventCardHeight * 0.17,
                          width: eventCardWidth,
                          child: AutoSizeText(
                            eventTitle,
                            style: const TextStyle(
                                fontSize: 24,
                                color: AppColors.kDarkGreen,
                                fontWeight: FontWeight.w600),
                            minFontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // DETAILS ROW
                      Row(
                        children: [
                          //---------------------------------------------- Date ------------------------------
                          Expanded(
                            child: Row(
                              children: [
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
                                  style: const TextStyle(
                                      color: AppColors.kForestGreen,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),

                          //---------------------------------------------- LOCATION ---------------------------
                          Expanded(
                            child: Row(
                              children: [
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
                                Flexible(
                                  child: Text(
                                    // here
                                    eventLocation,
                                    style: const TextStyle(
                                      color: AppColors.kForestGreen,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
