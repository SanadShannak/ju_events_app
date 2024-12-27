import 'package:flutter/material.dart';
import 'package:temp_project/utilities/constants.dart';

class AllEventsPage extends StatefulWidget {
  const AllEventsPage({super.key});

  @override
  State<AllEventsPage> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Icon(Icons.event),
    );
  }
}
