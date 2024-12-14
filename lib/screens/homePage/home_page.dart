import 'package:flutter/material.dart';
import 'package:temp_project/screens/homePage/components/event_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EventCard(
                backgroundImage: '',
                eventTitle: 'eventTitle',
                eventDate: 'eventDate',
                eventLocation: 'eventLocation'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/nameCollection');
                },
                child: const Text('back to data collection'))
          ],
        ),
      ),
    );
  }
}
