import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/models/user.dart';

import 'package:temp_project/services/auth_service.dart';
import 'package:temp_project/services/database_service/database_service.dart';
import 'package:temp_project/services/database_service/extensions/user_extensions.dart';
import 'package:temp_project/utilities/constants.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Future<User?>? _userFuture;
  String? teamName;
  String? userRole;

  @override
  void initState() {
    super.initState();
    _initializeUserProfile();
    _userFuture = _fetchUserDocument();
  }

  Future<void> _initializeUserProfile() async {
    await _getUserRole();
    if (userRole == 'team_leader') {
      await _fetchTeamName();
    }
  }

  Future<void> _getUserRole() async {
    final String? userId = AuthService.instance.getUserId();
    if (userId != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (mounted) {
        setState(() {
          userRole = userDoc['user_role'];
        });
      }
    }
  }

  Future<void> _fetchTeamName() async {
    final String? leaderId = AuthService.instance.getUserId();
    if (leaderId != null) {
      final name = await DatabaseService().getTeamNameByLeaderId();
      if (mounted) {
        setState(() {
          teamName = name;
        });
      }
    }
  }

  Future<User?> _fetchUserDocument() async {
    final User? userData = await DatabaseService().getUserDocument();
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0, top: 12.0),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    AuthService.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: const Icon(Icons.power_settings_new_sharp),
                  iconSize: 30,
                ),
              ],
            ),
          )
        ],
      ),
      body: FutureBuilder<User?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            ));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final User? user = snapshot.data;

          if (user == null) {
            return const Center(child: Text('User not found.'));
          }

          return SizedBox(
            width: size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width * .6),
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                        color: AppColors.kDarkGreen,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                //-------------------------------------------User Info Container-------------------------------------------
                Container(
                  width: size.width * .9,
                  color: AppColors.kPaleGoldenrod.withAlpha(26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const CircleAvatar(
                        radius: 55,
                        foregroundImage: AssetImage(
                          'lib/assets/images/others/default_profile_picture_gray.png',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(user.name, // Safely using user properties
                          style: const TextStyle(
                              color: AppColors.kDarkGreen,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      if (teamName != null)
                        const SizedBox(
                          height: 10,
                        ),
                      if (teamName != null)
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.kFernGreen,
                              borderRadius: BorderRadius.circular(16.0)),
                          padding: const EdgeInsets.all(10.0),
                          child: AutoSizeText(
                            teamName!,
                            style: const TextStyle(
                                color: AppColors.kBackground,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                      const SizedBox(height: 30),
                      //-------------------------------------------College-------------------------------------------
                      Container(
                          width: size.width * .9,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.kPaleGoldenrod,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('College: ',
                                    style: TextStyle(
                                        color: AppColors.kDarkGreen,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  user.institutionalUnitName, // Safely using user properties
                                  style: const TextStyle(
                                      color: AppColors.kDarkGreen,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      //-------------------------------------------Major-------------------------------------------
                      Container(
                          width: size.width * .9,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.kPaleGoldenrod,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Major: ',
                                    style: TextStyle(
                                        color: AppColors.kDarkGreen,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  user.major, // Safely using user properties
                                  style: const TextStyle(
                                      color: AppColors.kDarkGreen,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      //-------------------------------------------Role-------------------------------------------
                      Container(
                          width: size.width * .9,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.kPaleGoldenrod,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Role: ',
                                    style: TextStyle(
                                        color: AppColors.kDarkGreen,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  (userRole != null)
                                      ? (DatabaseService()
                                          .userRoleNameString(userRole!))
                                      : 'Student', // TODO: Change this to the user's role
                                  style: const TextStyle(
                                      color: AppColors.kDarkGreen,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
