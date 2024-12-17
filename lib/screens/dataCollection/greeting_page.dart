import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp_project/screens/authentication/components/custom_primary_button.dart';
import 'package:temp_project/utilities/constants.dart';

class GreetingPage extends StatelessWidget {
  const GreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: Stack(children: [
        Column(
          children: [
            const SizedBox(
              height: 90,
            ),
            SvgPicture.asset(
              'lib/assets/images/svg_files/welcome_data_collection.svg',
              width: 250,
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w900,
                color: AppColors.kForestGreen,
              ),
            ),
            const Text(
              'We are glad to have you onboard!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.kForestGreen,
              ),
            ),
            const SizedBox(
              height: 10,
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
            const SizedBox(
              height: 100,
            ),
            CustomPrimaryButton(
                prompt: 'Begin your journey',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/nameCollection',
                    (Route<dynamic> route) => false,
                  );
                })
          ],
        ),
      ]),
    );
  }
}
