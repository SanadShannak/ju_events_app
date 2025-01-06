import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp_project/services/database_service/extensions/interests_extensions.dart';

import '../../utilities/constants.dart';
import '../dataCollectionNavigation/components/interests_collection_widget.dart';
import 'event_provider.dart';

class EventTopics extends StatefulWidget {
  const EventTopics({super.key});

  @override
  State<EventTopics> createState() => _EventTopicsState();
}

class _EventTopicsState extends State<EventTopics> {
  List<String> interestsList = [];

  @override
  void initState() {
    super.initState();
    fetchInterests();
  }

  Future<void> fetchInterests() async {
    try {
      final fetchedInterests = await FirebaseFirestore.instance.fetchInterests();
      setState(() {
        interestsList = fetchedInterests;
      });
    } catch (e) {
      print('Error fetching interests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose The Event Topics',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.kDarkGreen),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: size.width * 1,
                  child: InterestsCollectionWidget<EventProvider>(
                    interestsList: interestsList,
                    maxNumberSelected: 5,
                    addInterest: (EventProvider provider, String interest) =>
                        context.read<EventProvider>().addTopic(interest),
                    removeInterest: (EventProvider provider, String interest) =>
                        context.read<EventProvider>().removeTopic(interest),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
