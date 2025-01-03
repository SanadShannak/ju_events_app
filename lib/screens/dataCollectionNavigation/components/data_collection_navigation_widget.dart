import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:temp_project/screens/dataCollectionNavigation/college_major_collection.dart';
import 'package:temp_project/screens/dataCollectionNavigation/interests_collection.dart';
import 'package:temp_project/screens/dataCollectionNavigation/name_collection.dart';
import 'package:temp_project/models/user.dart';
import 'package:temp_project/models/user_roles.dart';
import 'package:temp_project/providers/data_collection_provider.dart';
import 'package:temp_project/services/database_service/database_service.dart';
import 'package:temp_project/services/database_service/extensions/user_extensions.dart';
import 'package:temp_project/utilities/constants.dart';

class DataCollectionNavigation extends StatefulWidget {
  @override
  State<DataCollectionNavigation> createState() =>
      _DataCollectionNavigationState();
}

class _DataCollectionNavigationState extends State<DataCollectionNavigation> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    _pages = [
      NameCollectionPage(),
      CollegeMajorCollection(),
      InterestCollection(),
    ];
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Future<void> _finishDataCollection() async {
    final dataCollectionProvider =
        Provider.of<DataCollectionProvider>(context, listen: false);

    final user = User(
      name: dataCollectionProvider.name!,
      major: dataCollectionProvider.selectedMajor!,
      institutionalUnitId: dataCollectionProvider.selectedCollegeId!,
      institutionalUnitName: dataCollectionProvider.selectedCollege!,
      role: dataCollectionProvider.userRole,
      interests: dataCollectionProvider.selectedInterests!,
    );

    final status = await DatabaseService().createUserRecord(user);

    if (status == OperationStatus.success) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/mainPages', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create user record. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 75,
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: _pages.length,
            effect: const WormEffect(
              dotColor: Colors.grey,
              activeDotColor: AppColors.kPaleGoldenrod,
              dotHeight: 12,
              dotWidth: 12,
              spacing: 20,
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _pages,
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _currentPage == 0
                  ? Row(
                      children: [
                        SizedBox(),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            String? name = Provider.of<DataCollectionProvider>(
                                    context,
                                    listen: false)
                                .name;
                            if (name != null &&
                                name.trim().isNotEmpty &&
                                name.isNotEmpty) {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(
                                      seconds: 1, milliseconds: 500),
                                  content: const Text(
                                    'Please enter your name',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.kDarkGreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  backgroundColor: Colors.grey[300],
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(
                                color: AppColors.kDarkGreen, fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  : (_currentPage == 1
                      ? Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              },
                              child: const Text(
                                'Previous',
                                style: TextStyle(
                                    color: AppColors.kDarkGreen, fontSize: 16),
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                String? selectedCollege =
                                    Provider.of<DataCollectionProvider>(context,
                                            listen: false)
                                        .selectedCollege;
                                String? selectedMajor =
                                    Provider.of<DataCollectionProvider>(context,
                                            listen: false)
                                        .selectedMajor;
                                if (selectedCollege != null) {
                                  if (selectedMajor != null) {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(
                                            seconds: 1, milliseconds: 500),
                                        content: const Text(
                                          'Please select your major',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: AppColors.kDarkGreen,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        backgroundColor: Colors.grey[300],
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(
                                          seconds: 1, milliseconds: 500),
                                      content: const Text(
                                        'Please select your college and major',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.kDarkGreen,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      backgroundColor: Colors.grey[300],
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                    color: AppColors.kDarkGreen, fontSize: 16),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          // Final page
                          children: [
                            TextButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              },
                              child: const Text(
                                'Previous',
                                style: TextStyle(
                                    color: AppColors.kDarkGreen, fontSize: 16),
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                List? selectedInterests =
                                    Provider.of<DataCollectionProvider>(context,
                                            listen: false)
                                        .selectedInterests;
                                if (selectedInterests != null &&
                                    selectedInterests.length >= 1) {
                                  _finishDataCollection();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(
                                          seconds: 1, milliseconds: 500),
                                      content: const Text(
                                        'Please select atleast one interest',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.kDarkGreen,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      backgroundColor: Colors.grey[300],
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'Finish',
                                style: TextStyle(
                                    color: AppColors.kDarkGreen, fontSize: 16),
                              ),
                            ),
                          ],
                        ))),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: DataCollectionNavigation()));
}
