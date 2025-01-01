import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:intl/message_format.dart';
import 'package:temp_project/screens/all_events/all_events_page.dart';
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
    const HomePage(),
    const AllEventsPage(),
    const UserProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _currentIndex,
        backgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        showElevation: true,
        onItemSelected: (int newIndex) {
          setState(
            () {
              _currentIndex = newIndex;
            },
          );
        },
        items: [
          FlashyTabBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
              ),
              activeColor: AppColors.kFernGreen,
              inactiveColor: Colors.grey),
          FlashyTabBarItem(
              icon: Icon(Icons.event),
              title: Text('All Events'),
              activeColor: AppColors.kFernGreen,
              inactiveColor: Colors.grey),
          FlashyTabBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              activeColor: AppColors.kFernGreen,
              inactiveColor: Colors.grey)
        ],
      ),
    );
  }
}
