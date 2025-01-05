import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_project/screens/authentication/components/custom_primary_button.dart';
import 'package:temp_project/services/auth_service.dart';
import 'package:temp_project/utilities/constants.dart';

class GreetingPage extends StatelessWidget {
  const GreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var sizeMultiplier = size.height / 900;
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(children: [
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * .8, top: 8.0),
                  child: IconButton(
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
                ),
                const SizedBox(
                  height: 10,
                ),
                SvgPicture.asset(
                  'lib/assets/images/svg_files/welcome_data_collection.svg',
                  width: 250 * sizeMultiplier,
                ),
                SizedBox(
                  height: 60 * sizeMultiplier,
                ),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 60 * sizeMultiplier,
                    fontWeight: FontWeight.w900,
                    color: AppColors.kForestGreen,
                  ),
                ),
                Text(
                  'We are glad to have you onboard!',
                  style: TextStyle(
                    fontSize: 22 * sizeMultiplier,
                    fontWeight: FontWeight.w700,
                    color: AppColors.kForestGreen,
                  ),
                ),
                SizedBox(
                  height: 10 * sizeMultiplier,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: const Text(
                    'Before you embark on your first adventure            We need to know some information about you',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.kDarkGreen,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50 * sizeMultiplier,
                ),
                CustomPrimaryButton(
                    prompt: 'Begin your journey',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/dataCollectionPages',
                        (Route<dynamic> route) => false,
                      );
                    })
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
