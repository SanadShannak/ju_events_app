import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

import '../models/event_request_states.dart';

class EventWidget extends StatelessWidget {
  final String eventTitle;
  final String eventDate;
  final String eventLocation;
  final void Function()? onTap;
  final double height;
  final double width;
  final Widget? trailing;
  final EventRequestState? requestEventState;

  const EventWidget({
    super.key,
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    this.onTap,
    required this.height,
    required this.width,
    this.trailing,
    this.requestEventState,
  });

  const EventWidget.normalUser({
    super.key,
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    this.onTap,
    required this.height,
    required this.width,
  })  : trailing = null,
        requestEventState = null;

  const EventWidget.admin({
    super.key,
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    this.onTap,
    required this.height,
    required this.width,
  })  : trailing = const TeamLeaderTrailing(),
        requestEventState = null;

  EventWidget.teamLeader({
    super.key,
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    this.onTap,
    required this.height,
    required this.width,
    this.requestEventState,
  }) : trailing = AdminTrailing(eventRequestState: requestEventState!);

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
                    padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 5),
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
                                  color: AppColors.kForestGreen, fontSize: 10, fontWeight: FontWeight.w600),
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

class TeamLeaderTrailing extends StatelessWidget {
  const TeamLeaderTrailing({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.check, color: AppColors.kForestGreen),
          onPressed: () {
            // Handle accept logic
          },
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.redAccent),
          onPressed: () {
            // Handle reject logic
          },
        ),
      ],
    );
  }
}

class AdminTrailing extends StatelessWidget {
  const AdminTrailing({super.key, required this.eventRequestState});
  final EventRequestState eventRequestState;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        eventRequestState.name[0].toUpperCase() + eventRequestState.name.substring(1),
        style: TextStyle(
          fontSize: 14,
          color: AppColors.getColorForState(eventRequestState),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
