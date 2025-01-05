import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/screens/events/admin_pending_events.dart';

import 'package:temp_project/screens/events/events_page.dart';
import 'package:temp_project/screens/events/team_requested_events_page.dart';
import 'package:temp_project/screens/homePage/home_page.dart';
import 'package:temp_project/screens/profilePage/user_profile_page.dart';
import 'package:temp_project/services/auth_service.dart';
import 'package:temp_project/utilities/constants.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({super.key});

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int _currentIndex = 0;
  String? userRole;

  final List<Widget> _normalUserPages = [
    const HomePage(),
    EventsPage.all(),
    const UserProfilePage(),
  ];

  final List<Widget> _teamUserPages = [
    const HomePage(),
    EventsPage.all(),
    const TeamRequestedEventsPage(),
    const UserProfilePage(),
  ];
  final List<Widget> _adminUserPages = [
    const HomePage(),
    EventsPage.all(),
    const AdminPendingEvents(), //TODO: Change this to Requested Events for Admin Page
    const UserProfilePage(),
  ];

  Future<void> _getUserRole() async {
    final String? userId = AuthService.instance.getUserId();
    if (userId != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      setState(() {
        userRole = userDoc['user_role'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userRole == "admin"
          ? _adminUserPages[_currentIndex]
          : userRole == "team_leader"
              ? _teamUserPages[_currentIndex]
              : userRole == "normal_user"
                  ? _normalUserPages[_currentIndex]
                  : null,
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
          //--------------------------If user is team leader--------------------------
          if (userRole == "team_leader")
            FlashyTabBarItem(
                icon: const Icon(Icons.hourglass_bottom_rounded),
                title: const Text(
                  'Requested Events',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
                activeColor: AppColors.kFernGreen,
                inactiveColor: Colors.grey),
          //--------------------------If user is admin--------------------------
          if (userRole == "admin")
            FlashyTabBarItem(
                icon: const Icon(Icons.pending),
                title: const Text(
                  'Pending Requests',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
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
