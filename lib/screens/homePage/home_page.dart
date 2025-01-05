import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for DateFormat
import 'package:temp_project/screens/homePage/components/event_details_screen.dart';
import 'package:temp_project/services/auth_service.dart';
import 'package:temp_project/services/database_service/extensions/event_extensions.dart';

import '../../models/event.dart';
import '../../models/institutional_unit.dart';
import '../../services/database_service/database_service.dart';
import '../../utilities/constants.dart';
import '../../utilities/testing_random_image_generator.dart';
import '../events/events_page.dart';
import 'components/calendar_widget.dart';
import 'components/event_card.dart';
import 'components/institutional_unit_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * .05),
            child: Column(
              children: [
                //------------------------------------ 'Events that might interest you' text ---------------------------
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

                //------------------------------------ 'Events that might interest you' text ---------------------------

                SizedBox(
                  height: size.height * .01,
                ),

                //------------------------------------ Event Cards -----------------------------------------------------
                SizedBox(
                  height: size.width * .59,
                  child: FutureBuilder<QuerySnapshot?>(
                    // Replace the old future method with the new one
                    future: DatabaseService()
                        .getMatchingEvents(AuthService.instance.getUserId()!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.kDarkGreen,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (snapshot.hasData && snapshot.data != null) {
                        final documents = snapshot.data!.docs;

                        if (documents.isEmpty) {
                          return const Center(child: Text('No events found.'));
                        }

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final eventData = documents[index].data()
                                as Event; // Convert to Map<String, dynamic>
                            final event =
                                eventData; // Convert map to Event object
                            final imagePath =
                                'lib/assets/images/event_card_images_by_index/${RandomImageGenerator.getRandomEventImagePath()}';

                            return Padding(
                              padding: index == 0
                                  ? const EdgeInsets.only(
                                      top: 14.0, bottom: 14.0, left: 35)
                                  : (index == documents.length - 1
                                      ? const EdgeInsets.only(
                                          top: 14.0, bottom: 14.0, right: 35)
                                      : const EdgeInsets.symmetric(
                                          vertical: 14.0)),
                              child: EventCard(
                                backgroundImage: imagePath,
                                eventTitle: event.name,
                                eventDate: DateFormat('dd/MM/yyyy')
                                    .format(event.dateTime),
                                eventLocation: event.locationInfo,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EventDetails(
                                                event: event,
                                                imagePath: imagePath,
                                              )));
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: size.width * .05,
                            );
                          },
                        );
                      }

                      return const Center(child: Text('No events found.'));
                    },
                  ),
                ),
                //------------------------------------ Event Cards -----------------------------------------------------

                const SizedBox(
                  height: 40,
                ),

                //------------------------------------ 'Events By Date' text -------------------------------------------
                Container(
                    width: size.width * 0.9,
                    height: size.height * 0.05,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Events By Date',
                      style: TextStyle(
                        fontSize: 23, // Adjust font size
                        fontWeight: FontWeight.w600,
                        color: AppColors.kDarkGreen, // Set color
                      ),
                    )),
                //------------------------------------ 'Events By Date' text -------------------------------------------

                //------------------------------------ Calendar Widget -------------------------------------------------
                SizedBox(
                    width: size.width * .95, child: const CalendarWidget()),
                //------------------------------------ Calendar Widget -------------------------------------------------

                const SizedBox(
                  height: 20,
                ),

                //------------------------------------ 'Events By Institutional Unit' text -----------------------------
                Container(
                  width: size.width * 0.9,
                  height: size.height * 0.05,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Events By Institutional Unit',
                    style: TextStyle(
                      fontSize: 23, // Adjust font size
                      fontWeight: FontWeight.w600,
                      color: AppColors.kDarkGreen, // Set color
                    ),
                  ),
                ),
                //------------------------------------ 'Events By Institutional Unit' text -----------------------------

                const SizedBox(
                  height: 20,
                ),
                //------------------------------------ Institutional Unit Cards ----------------------------------------
                SizedBox(
                  width: size.width * .9,
                  child: FutureBuilder(
                    future: DatabaseService()
                        .getAllDocuments(CollectionRefs.institutionalUnits),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.kDarkGreen,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (snapshot.hasData && snapshot.data != null) {
                        final documents = snapshot.data?.docs;

                        return Wrap(
                          alignment: WrapAlignment.spaceAround,
                          spacing: 20.0,
                          runSpacing: 36.0,
                          children: List.generate(documents!.length, (index) {
                            final unitData =
                                documents[index].data() as InstitutionalUnit;
                            final unitName = unitData.name;
                            final imagePath =
                                'lib/assets/images/college_card_images_by_index/${RandomImageGenerator.getRandomInstitutionalUnitImagePath()}';

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EventsPage
                                                .filteredByInstitutionalUnit(
                                              institutionalUnit: unitName,
                                              showBackButton: true,
                                            )));
                              },
                              child: InstitutionalUnitCard(
                                name: unitName,
                                imagePath: imagePath,
                              ),
                            );
                          }),
                        );
                      }

                      return const Center(
                          child: Text('No institutional units found.'));
                    },
                  ),
                ),
                //------------------------------------ Institutional Unit Cards ----------------------------------------
              ],
            ),
          ),
        ),
      ),
    );
  }
}
