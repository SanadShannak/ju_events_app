import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:temp_project/screens/dataCollectionNavigation/components/interests_collection_widget.dart';

import 'package:temp_project/services/database_service/extensions/interests_extensions.dart';
import 'package:temp_project/utilities/constants.dart';

class InterestCollection extends StatefulWidget {
  const InterestCollection({super.key});

  @override
  State<InterestCollection> createState() => _InterestCollectionState();
}

class _InterestCollectionState extends State<InterestCollection> {
  List<String> interestsList = [];

  @override
  void initState() {
    super.initState();
    fetchInterests();
  }

  Future<void> fetchInterests() async {
    try {
      final fetchedInterests =
          await FirebaseFirestore.instance.fetchInterests();
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

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'What are your interests?',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kDarkGreen),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: size.width * 1,
                      child: InterestsCollectionWidget(
                        interestsList: interestsList,
                        maxNumberSelected: 5,
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
