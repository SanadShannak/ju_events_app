import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_project/models/event_request_states.dart';

import 'package:temp_project/models/requested_event.dart';
import 'package:temp_project/screens/homePage/components/event_details_screen.dart';
import 'package:temp_project/services/database_service/database_service.dart'
    as DBService;
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
      final name = await DBService.DatabaseService().getTeamNameByLeaderId();
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
                  DBService.DatabaseService().getPendingEventsToCurrentUser(),
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

                  return ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView

                    itemCount: documents?.length,

                    itemBuilder: (context, index) {
                      // Safely parse document data into the Event model
                      final eventData =
                          documents?[index].data() as RequestedEvent;
                      final eventId = documents?[index].id;

                      if (eventData.requestState == EventRequestState.pending) {
                        setState(() {});

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
                            ),
                          ),
                        );
                      }
                      return Center(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.width * .75),
                              child: const Text(
                                'No Pending Events.',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.kDarkGreen),
                                textAlign: TextAlign.center,
                              )));
                    },
                  );
                }

                return const Center(child: Text('No Pending Events.'));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(
              'Floating Action Button Pressed'); // TODO: change the floating action button press function
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
