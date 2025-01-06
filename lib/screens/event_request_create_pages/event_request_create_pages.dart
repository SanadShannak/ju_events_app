import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp_project/models/event_request_states.dart';
import 'package:temp_project/models/institutional_unit.dart';
import 'package:temp_project/models/requested_event.dart';
import 'package:temp_project/providers/data_collection_provider.dart';
import 'package:temp_project/screens/event_request_create_pages/collect_event_details.dart';
import 'package:temp_project/screens/event_request_create_pages/event_provider.dart';
import 'package:temp_project/services/database_service/database_service.dart';
import 'package:temp_project/services/database_service/extensions/user_extensions.dart';
import 'package:temp_project/widgets/custom_app_bar.dart';

import '../../models/event.dart';
import '../../models/user.dart';
import '../../models/user_roles.dart';
import '../../services/auth_service.dart';
import '../../utilities/constants.dart';
import '../../utilities/theme/theme.dart';
import 'collect_event_topics.dart';

class EventRequestCreatePages extends StatefulWidget {
  const EventRequestCreatePages({super.key, required this.user});
  final User user;

  @override
  State<EventRequestCreatePages> createState() =>
      _EventRequestCreatePagesState();
}

class _EventRequestCreatePagesState extends State<EventRequestCreatePages> {
  final List<Widget> _pages = [const EventDetails(), const EventTopics()];
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_pageController.page != null &&
        context.read<EventProvider>().eventDetailsWidgetValidator()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_pageController.page != null && _currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finish() async {
    final eventProvider = context.read<EventProvider>();
    final authService = AuthService.instance;

    if (!eventProvider.eventTopicsWidgetValidator()) {
      await _showSnackBar(
          'Please select at least one interest', AppColors.kDarkGreen);
      return;
    }

    eventProvider.postedById = authService.getUserId();
    eventProvider.postedByName = widget.user.name;

    final eventInfo = eventProvider.getEvent();
    if (eventInfo == null) {
      await _showSnackBar(
          'Failed to Get Event Information, Please Try Later.', Colors.red);
      _navigateToOriginPage();
      return;
    }

    if (widget.user.role == UserRole.teamLeader) {
      await _handleTeamLeader(eventInfo);
    } else if (widget.user.role == UserRole.admin) {
      await _handleAdmin(eventInfo);
    }

    await Future.delayed(const Duration(seconds: 2));
    _navigateToOriginPage();
  }

  Future<void> _handleTeamLeader(Event eventInfo) async {
    InstitutionalUnit inst;
    final instDoc = await DatabaseService().getDocument(
      CollectionRefs.institutionalUnits,
      widget.user.institutionalUnitId,
    );
    if (instDoc != null) {
      inst = instDoc.data() as InstitutionalUnit;
    } else {
      await _showSnackBar(
          'Failed to Send Event Request, Please Try Later.', Colors.red);
      return;
    }

    String? postedById = await DatabaseService().getTeamIdByLeaderId();
    String? postedByName = await DatabaseService().getTeamNameByLeaderId();

    final eventRequest = RequestedEvent(
      name: eventInfo.name,
      dateTime: eventInfo.dateTime,
      locationInfo: eventInfo.locationInfo,
      subLocationInfo: eventInfo.subLocationInfo,
      topics: eventInfo.topics,
      description: eventInfo.description,
      postedById: postedById!,
      postedByName: postedByName!,
      //postedById: AuthService.instance.getUserId().toString(),
      // postedByName: widget.user.name,
      requestDateTime: Timestamp.now(),
      initiatorId: AuthService.instance.getUserId().toString(),
      initiatorName: widget.user.name,
      targetId: inst.adminId,
      targetName: inst.adminName,
      requestState: EventRequestState.pending,
    );

    final operationStatus = await DatabaseService()
        .addDocument(CollectionRefs.requestedEvents, eventRequest);
    if (operationStatus == OperationStatus.success && mounted) {
      await _showSnackBar(
          'Event Request Sent Successfully', AppColors.kDarkGreen);
    } else if (mounted) {
      await _showSnackBar(
          'Failed to Send Event Request, Please Try Later.', Colors.red);
    }
    Provider.of<DataCollectionProvider>(context, listen: false)
        .resetDataToNull();
  }

  Future<void> _handleAdmin(Event eventInfo) async {
    final operationStatus =
        await DatabaseService().addDocument(CollectionRefs.events, eventInfo);
    if (operationStatus == OperationStatus.success && mounted) {
      await _showSnackBar('Event Published Successfully', AppColors.kDarkGreen);
    } else if (mounted) {
      await _showSnackBar(
          'Failed to Publish Event, Please Try Later.', Colors.red);
    }
  }

  Future<void> _showSnackBar(String message, Color textColor) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1, milliseconds: 500),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.w500, fontSize: 14),
        ),
        backgroundColor: Colors.grey[300],
      ),
    );
  }

  void _navigateToOriginPage() {
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        titleWidget: Text(
          widget.user.role == UserRole.teamLeader
              ? 'Event Request'
              : 'Create Event',
          style: const TextStyle(
              color: AppColors.kDarkGreen,
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        showBackButton: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _pages,
            ),
          ),
          Row(
            children: [
              // Show "Previous" button if not on the first page
              if (_currentPage != 0)
                NavigationButton(
                  prompt: 'Previous',
                  onPressed: _previousPage,
                ),
              const Spacer(),
              // Show "Next" button if not on the last page
              if (_currentPage < _pages.length - 1)
                NavigationButton(
                  prompt: 'Next',
                  onPressed: _nextPage,
                ),
              // Show "Finish" button on the last page
              if (_currentPage == _pages.length - 1)
                NavigationButton(
                  prompt: 'Finish',
                  onPressed: _finish,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton({super.key, required this.prompt, this.onPressed});
  final String prompt;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          prompt,
          style: const TextStyle(color: AppColors.kDarkGreen, fontSize: 16),
        ),
      ),
    );
  }
}

void main() async {
  Firebase.initializeApp();
  runApp(const JUEvents());
}

class JUEvents extends StatelessWidget {
  const JUEvents({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: MaterialApp(
        theme: AppTheme.lightTheme,
        home: Provider(
          create: (context) => EventProvider(),
          child: EventRequestCreatePages(
            user: User(
                name: 'name',
                major: 'major',
                institutionalUnitId: 'institutionalUnitId',
                institutionalUnitName: 'institutionalUnitName',
                role: UserRole.admin,
                interests: []),
          ),
        ),
      ),
    );
  }
}
