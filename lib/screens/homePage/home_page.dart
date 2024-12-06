import 'package:flutter/material.dart';
import 'package:temp_project/screens/homePage/components/calendar_widget.dart';
import 'package:temp_project/screens/homePage/components/event_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: 50,
              ),
              EventCard(
                  backgroundImage:
                      'lib/assets/images/event_card_images/background-image.jpg',
                  eventTitle: 'ROBOTICS AND AI',
                  eventDate: '13 JAN 2024',
                  eventLocation: 'KASIT SCHOOL'),
              SizedBox(
                width: 30,
              ),
              EventCard(
                  backgroundImage:
                      'lib/assets/images/event_card_images/background-image.jpg',
                  eventTitle: 'ROBOTICS AND AI',
                  eventDate: '13 JAN 2024',
                  eventLocation: 'KASIT SCHOOL'),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        CalendarWidget(),
      ],
    ));
  }
}
