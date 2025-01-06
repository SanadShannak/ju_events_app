import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:temp_project/models/requested_event.dart';
import 'package:temp_project/models/user.dart' as userModel;
import 'package:temp_project/providers/data_collection_provider.dart';
import 'package:temp_project/screens/event_request_create_pages/event_provider.dart';
import 'package:temp_project/screens/event_request_create_pages/event_request_create_pages.dart';
import 'package:temp_project/screens/homePage/components/event_details_screen.dart';
import 'package:temp_project/services/database_service/database_service.dart'
    as dbService;
import 'package:temp_project/services/database_service/extensions/requested_event_extensions.dart';

import 'package:temp_project/services/database_service/extensions/user_extensions.dart';
import 'package:temp_project/utilities/constants.dart';
import 'package:temp_project/widgets/custom_app_bar.dart';
import 'package:temp_project/widgets/event_widget.dart';

class AdminPendingEvents extends StatefulWidget {
  const AdminPendingEvents({super.key});

  @override
  State<AdminPendingEvents> createState() => _AdminPendingEventsState();
}

class _AdminPendingEventsState extends State<AdminPendingEvents> {
  String? teamName;

  @override
  void initState() {
    super.initState();

    _fetchTeamName();
  }

  Future<void> _fetchTeamName() async {
    final String? adminId = FirebaseAuth.instance.currentUser?.uid;
    if (adminId != null) {
      final name = await dbService.DatabaseService().getTeamNameByLeaderId();
      setState(() {
        teamName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(
        titleWidget:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Pending Events',
              style: TextStyle(
                  color: AppColors.kDarkGreen,
                  fontWeight: FontWeight.w600,
                  fontSize: 18)),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future:
                  dbService.DatabaseService().getPendingEventsToCurrentUser(),
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
                  if (snapshot.error.toString() == '{null}') {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: size.width * .55),
                      child: const Text(
                        'No Pending Events.',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kDarkGreen),
                        textAlign: TextAlign.center,
                      ),
                    ));
                  }
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
                        final eventData =
                            documents[index].data() as RequestedEvent;
                        final eventId = documents[index].id;

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
                            child: EventWidget.admin(
                              width: size.width * 0.9,
                              height: 80,
                              eventDate: DateFormat('dd-MM-yyyy')
                                  .format(eventData.dateTime),
                              eventLocation: eventData.locationInfo,
                              eventTitle: eventData.name,
                              requestedEventId: eventId,
                              onRequestedEventStateChange: () {
                                setState(() {});
                              },
                              eventData: eventData,
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
                              'No Pending Events',
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final userModel.User? currentUser =
              await dbService.DatabaseService().getUserDocument();
          if (currentUser != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Provider<EventProvider>(
                        create: (context) => EventProvider(),
                        child: EventRequestCreatePages(user: currentUser),
                      )),
            );
          } else {
            // Handle the case where user details could not be fetched
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to fetch user details')),
            );
          }
          Provider.of<DataCollectionProvider>(context, listen: false)
              .resetDataToNull();
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
        backgroundColor: AppColors.kForestGreen,
        child: const Icon(
          Icons.add,
          size: 32.0,
          color: AppColors.kBackground,
        ),
      ),
    );
  }
}
