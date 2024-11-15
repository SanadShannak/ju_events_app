import 'package:flutter/material.dart';
import 'package:ju_events_app/screens/sign_up/sign_up_screen.dart';
import 'package:ju_events_app/utilities/constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: AppColors.kBackground),
      home: Scaffold(
        body: SignUpScreen(),
      ),
    );
  }
}
