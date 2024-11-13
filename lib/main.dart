import 'package:flutter/material.dart';
import 'package:ju_events_app/screens/login/login_screen.dart';

void main() {
  return runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      darkTheme: ThemeData(),
      home: const LoginScreen(),
    );
  }
}
