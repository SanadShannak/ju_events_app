import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/models/event.dart';
import 'package:temp_project/models/requested_event.dart';
import 'package:temp_project/services/database_service/database_service.dart';
import 'package:temp_project/services/database_service/extensions/requested_event_extensions.dart';
import 'package:temp_project/utilities/constants.dart';

import '../models/event_request_states.dart';

// ignore: must_be_immutable
class EventWidget extends StatelessWidget {
  final String eventTitle;
  final String eventDate;
  final String eventLocation;
  final void Function()? onTap;
  final double height;
  final double width;
  final Widget? trailing;
  final EventRequestState? requestEventState;
  final String? requestedEventId;

  VoidCallback? onRequestedEventStateChange;

  RequestedEvent? eventData;

  EventWidget({
    super.key,
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    this.onTap,
    required this.height,
    required this.width,
    this.trailing,
    this.requestEventState,
    this.requestedEventId,
  });

  EventWidget.normalUser({
    super.key,
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    this.onTap,
    required this.height,
    required this.width,
    this.requestedEventId,
  })  : trailing = null,
        requestEventState = null;

  EventWidget.admin({
    super.key,
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    this.onTap,
    required this.height,
    required this.width,
    this.requestEventState,
    required this.requestedEventId,
    required this.onRequestedEventStateChange,
    required this.eventData,
  }) : trailing = AdminTrailing(
            eventData: eventData!,
            requestedEventId: requestedEventId!,
            onRequestedEventStateChange: onRequestedEventStateChange!);

  EventWidget.teamLeader({
    super.key,
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    this.onTap,
    required this.height,
    required this.width,
    this.requestEventState,
    this.requestedEventId,
  }) : trailing = TeamLeaderTrailing(
          eventRequestState: requestEventState!,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //------------------------------------------Container Properties------------------------------------
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.kPaleGoldenrod.withAlpha(75),
          borderRadius: BorderRadius.circular(16),
        ),
        //------------------------------------------Event Details-------------------------------------------
        child: Row(
          children: [
            Expanded(
              flex: 73,
              child: Column(
                children: [
                  //---------------------------------------------- Title ------------------------------
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 10, top: 10, bottom: 5),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: height * 0.5,
                        maxWidth: width,
                      ),
                      height: height * 0.5,
                      width: width,
                      child: AutoSizeText(
                        eventTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          color: AppColors.kDarkGreen,
                          fontWeight: FontWeight.w600,
                        ),
                        minFontSize: 16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      //---------------------------------------------- Date ------------------------------
                      Expanded(
                        flex: 4,
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
                            const SizedBox(
                              width: 5,
                            ),
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

                      //---------------------------------------------- Location ---------------------------
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            Image.asset(
                              'lib/assets/images/icons/location.png',
                              color: AppColors.kDarkGreen,
                              width: 15,
                              height: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // ---------------------------------------- Actions or State ( tiler )---------------------------------
            if (trailing != null) ...[
              Expanded(
                flex: 27,
                child: trailing!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AdminTrailing extends StatelessWidget {
  const AdminTrailing({
    super.key,
    required this.requestedEventId,
    required this.onRequestedEventStateChange,
    required this.eventData,
  });
  final String requestedEventId;
  final VoidCallback onRequestedEventStateChange;
  final RequestedEvent eventData;

  Future<void> _updateEventState(String eventId, String newState) async {
    await DatabaseService().updateRequestedEventState(eventId, newState);
    onRequestedEventStateChange();
  }

  Future<void> _handleAcceptedEvent(String acceptedEventId) async {
    final acceptedEvent = Event(
        name: eventData.name,
        dateTime: eventData.dateTime,
        locationInfo: eventData.locationInfo,
        subLocationInfo: eventData.subLocationInfo,
        topics: eventData.topics,
        description: eventData.description,
        postedById: eventData.postedById,
        postedByName: eventData.postedByName);
    DatabaseService().addDocument(CollectionRefs.events, acceptedEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.check, color: AppColors.kForestGreen),
          onPressed: () async {
            await _updateEventState(requestedEventId, 'accepted');
            await _handleAcceptedEvent(requestedEventId);
          },
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.redAccent),
          onPressed: () async {
            await _updateEventState(requestedEventId, 'rejected');
          },
        ),
      ],
    );
  }
}

class TeamLeaderTrailing extends StatelessWidget {
  const TeamLeaderTrailing({super.key, required this.eventRequestState});
  final EventRequestState eventRequestState;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        eventRequestState.name[0].toUpperCase() +
            eventRequestState.name.substring(1),
        style: TextStyle(
          fontSize: 14,
          color: AppColors.getColorForState(eventRequestState),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
