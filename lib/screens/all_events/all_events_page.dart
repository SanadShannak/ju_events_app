import 'package:flutter/material.dart';
import 'package:temp_project/widgets/event_widget.dart';

import '../../utilities/constants.dart';
import '../../widgets/search_widget.dart';

class AllEventsPage extends StatefulWidget {
  const AllEventsPage({super.key});

  @override
  State<AllEventsPage> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
        actions: const [
          SearchWidget(
            widthRatio: 0.5,
          )
        ],
      ),
      body: ListView(
        children: [
          // Filter
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                //TODO: Add Filter Logic
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 24, top: 16, bottom: 32),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Filter',
                      style: TextStyle(
                        color: AppColors.kDarkGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'lib/assets/images/icons/filter.png',
                      width: 15,
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // TODO: Add Events here
          // this is just an example
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: EventWidget(
                    eventTitle: 'Robotics and AI',
                    eventDate: '22-02-2024',
                    eventLocation: 'KASIT School',
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.95),
              ),
              EventWidget(
                  eventTitle: 'Robotics and AI',
                  eventDate: '22-02-2024',
                  eventLocation: 'KASIT School',
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.95),
            ],
          )
        ],
      ),
    );
  }
}
