import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../utilities/constants.dart';
import '../authentication/components/custom_primary_button.dart';
import 'components/calendar_widget.dart';
import 'components/event_card.dart';
import 'components/institutional_unit_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),

              // welcome text
              Container(
                width: size.width * 0.7,
                height: size.height * 0.2,
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center, // Optional, centers the text
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Let\'s Find Your Next Adventure on Campus with ',
                        style: TextStyle(
                          fontSize: 18, // Adjust font size
                          fontWeight: FontWeight.w500,
                          color: AppColors.kDarkGreen, // Set color
                        ),
                      ),
                      TextSpan(
                        text: 'JuEvents !',
                        style: TextStyle(
                          fontSize: 24, // Adjust font size
                          color: AppColors.kDarkGreen, // Set color
                          fontWeight: FontWeight.w600, // Bold for emphasis
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Sign out Button
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomPrimaryButton(
                  onPressed: () {
                    AuthService.instance.signOut().then((errorMessage) {
                      if (errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(errorMessage)),
                        );
                      } else {
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    });
                  },
                  prompt: 'Sign Out',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const InstitutionalUnitCard(
                imagePath: 'lib/assets/images/event_card_images/background-image.jpg',
                name: 'KASIT School',
              ),
              const SizedBox(
                height: 10,
              ),
              const EventCard(
                backgroundImage: 'lib/assets/images/event_card_images/background-image.jpg',
                eventDate: '20/2/2022',
                eventLocation: 'KASIT School',
                eventTitle: 'Robotics and AI',
              ),
              const SizedBox(
                height: 10,
              ),
              const CalendarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
