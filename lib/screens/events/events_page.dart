import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_project/services/database_service/extensions/event_extensions.dart';
import 'package:temp_project/widgets/custom_app_bar.dart';
import 'package:temp_project/widgets/event_widget.dart';

import '../../models/event.dart';
import '../../services/database_service/database_service.dart';
import '../../utilities/constants.dart';
import '../homePage/components/event_details_screen.dart';

// ignore: must_be_immutable
class EventsPage extends StatefulWidget {
  EventsPage.all({
    super.key,
  })  : dateTime = null,
        appBarTitle = 'All Events',
        institutionalUnit = null;

  EventsPage.filteredByInstitutionalUnit({
    super.key,
    required this.institutionalUnit,
    required this.showBackButton,
  })  : dateTime = null,
        appBarTitle = institutionalUnit;

  // Named constructor for filtering by date
  EventsPage.filteredByDate({
    super.key,
    required this.dateTime,
    required this.showBackButton,
  })  : institutionalUnit = null,
        appBarTitle = 'Events on ${DateFormat('dd/MM/yyyy').format(dateTime!)}';

  final String? institutionalUnit;
  final String? appBarTitle;
  final DateTime? dateTime;
  bool? showBackButton;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: widget.showBackButton == true ? true : false,
        titleWidget: Text(widget.appBarTitle ?? 'All Events',
            style: const TextStyle(
                color: AppColors.kDarkGreen,
                fontWeight: FontWeight.w600,
                fontSize: 20)),
        // actions: const [
        //   SearchWidget(
        //     widthRatio: 0.5,
        //   )
        // ],),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Filter
            // Align(
            //   alignment: Alignment.topRight,
            //   child: GestureDetector(
            //     onTap: () {
            //       //TODO: Add Filter Logic
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.only(right: 24, top: 16, bottom: 32),
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           const Text(
            //             'Filter',
            //             style: TextStyle(
            //               color: AppColors.kDarkGreen,
            //               fontSize: 16,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           const SizedBox(
            //             width: 10,
            //           ),
            //           Image.asset(
            //             'lib/assets/images/icons/filter.png',
            //             width: 15,
            //             height: 15,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            // TODO: Add Events here
            // this is just an example
            FutureBuilder(
              future: widget.institutionalUnit != null
                  ? DatabaseService()
                      .getEventsByInstitutionalUnit(widget.institutionalUnit!)
                  : widget.dateTime != null
                      ? DatabaseService().getEventsByDate(widget.dateTime!)
                      : DatabaseService()
                          .getAllDocuments(CollectionRefs.events),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: AppColors.kDarkGreen,
                    )),
                  );
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData && snapshot.data != null) {
                  final documents = snapshot.data?.docs;
                  if (documents!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        // Safely parse document data into the Event model
                        final eventData = documents[index].data() as Event;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EventDetails(event: eventData)));
                            },
                            child: EventWidget(
                              width: size.width * 0.9,
                              height: 80,
                              eventDate: DateFormat('dd-MM-yyyy')
                                  .format(eventData.dateTime),
                              eventLocation: eventData.locationInfo,
                              eventTitle: eventData.name,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                        // If there are no events pending to this user
                        child: Container(
                            height: size.height,
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * .75),
                            child: const Text(
                              'No Events Available',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kDarkGreen),
                              textAlign: TextAlign.center,
                            )));
                  }
                }

                return Center(child: Text('Error: ${snapshot.error}'));
              },
            )
          ],
        ),
      ),
    );
  }
}
