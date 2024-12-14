import 'package:flutter/material.dart';
import 'package:temp_project/screens/dataCollection/components/data_collection_widget.dart';
import 'package:temp_project/screens/dataCollection/college_major_collection.dart';
import 'package:temp_project/screens/dataCollection/components/interests_collection_widget.dart';
import 'package:temp_project/screens/homePage/home_page.dart';
import 'package:temp_project/utilities/constants.dart';

class InterestCollection extends StatelessWidget {
  InterestCollection({super.key});
  final GlobalKey<FormState> _interestsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> interestsList = [
      'Engineering',
      'Biology',
      'Computer',
      'Agriculture',
      'Chemistry',
      'Physics',
      'Astronomy',
    ];

    return Scaffold(
        body: DataCollectionWidget(
      pageBody: Column(
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
            height: 150,
          ),
          Container(
              width: size.width * 1,
              child: InterestsCollectionWidget(
                interestsList: interestsList,
                maxNumberSelected: 5,
              )),
        ],
      ),
      dataCollectionPageIndex: 2,
      nextPage: const HomePage(),
      previousPage: const CollegeMajorCollection(),
    ));
  }
}
