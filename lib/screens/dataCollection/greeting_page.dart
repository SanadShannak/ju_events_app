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
              'lib/assets/images/emojis/party-popper-emoji2.svg',
              width: 250,
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: AppColors.kForestGreen,
                shadows: [
                  Shadow(
                    offset: Offset(0, 3.0),
                    blurRadius: 7.0,
                    color: AppColors.kFernGreen,
                  ),
                ],
              ),
            ),
            const Text(
              'We are glad to have you onboard!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.kForestGreen,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'Before you embark on your first adventure            we need to know some information about you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Divider(
              indent: 40,
              endIndent: 40,
              thickness: 2,
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
