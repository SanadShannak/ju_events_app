import 'package:flutter/material.dart';
import 'package:temp_project/models/user.dart';
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

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUserDocument();
  }

  Future<User?> _fetchUserDocument() async {
    final userData = await DatabaseService().getUserDocument();
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

          return Container(
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
                  height: 30,
                ),
                //-------------------------------------------User Info Container-------------------------------------------
                Container(
                  width: size.width * .9,
                  height: size.height * .5,
                  color: AppColors.kPaleGoldenrod.withOpacity(.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const CircleAvatar(
                        radius: 55,
                        foregroundImage: AssetImage(
                          'lib/assets/images/others/ahmad_profile_picture.png',
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(user.name, // Safely using user properties
                          style: const TextStyle(
                              color: AppColors.kDarkGreen,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 25),
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
                                Text('College: ',
                                    style: const TextStyle(
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
                                Text('Major: ',
                                    style: const TextStyle(
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
                                Text('Role: ',
                                    style: const TextStyle(
                                        color: AppColors.kDarkGreen,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  'Student', // TODO: Change this to the user's role
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
