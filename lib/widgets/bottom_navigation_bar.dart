import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/message_format.dart';
import 'package:temp_project/screens/allEventsPage/all_events_page.dart';
import 'package:temp_project/screens/homePage/home_page.dart';
import 'package:temp_project/screens/profilePage/user_profile_page.dart';
import 'package:temp_project/utilities/constants.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({super.key});

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    AllEventsPage(),
    UserProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'All Events'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        selectedItemColor: AppColors.kFernGreen,
        backgroundColor: Colors.white,
      ),
    );
  }
}
