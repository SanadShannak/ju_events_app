import 'package:flutter/material.dart';
import 'package:temp_project/screens/authentication/login_page.dart';

void main() => runApp(const JUEvents());

class JUEvents extends StatelessWidget {
  const JUEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
