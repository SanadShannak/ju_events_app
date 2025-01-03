import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/screens/events/events_page.dart';
import 'package:temp_project/screens/homePage/home_page.dart';
import 'package:temp_project/screens/profilePage/user_profile_page.dart';
import 'package:temp_project/utilities/constants.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({super.key});

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const EventsPage.all(),
    const UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _currentIndex,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
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
              icon: const Icon(Icons.home),
              title: const Text(
                'Home',
              ),
              activeColor: AppColors.kFernGreen,
              inactiveColor: Colors.grey),
          FlashyTabBarItem(
              icon: const Icon(Icons.event),
              title: const Text('All Events'),
              activeColor: AppColors.kFernGreen,
              inactiveColor: Colors.grey),
          FlashyTabBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: AppColors.kFernGreen,
              inactiveColor: Colors.grey)
        ],
      ),
    );
  }
}
