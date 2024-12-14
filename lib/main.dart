import 'package:flutter/material.dart';
import 'package:temp_project/screens/authentication/landing_page.dart';
import 'package:temp_project/screens/authentication/login_page.dart';
import 'package:temp_project/screens/authentication/signup_page.dart';
import 'package:temp_project/screens/dataCollection/greeting_page.dart';

import 'package:temp_project/screens/dataCollection/name_collection.dart';
import 'package:temp_project/screens/homePage/home_page.dart';

import 'package:temp_project/utilities/theme/theme.dart';

void main() => runApp(const JUEvents());

class JUEvents extends StatelessWidget {
  const JUEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/nameCollection': (context) => NameCollectionPage(),
        '/greetingPage': (context) => const GreetingPage(),
        '/homePage': (context) => const HomePage(),
      },
      // theme: ThemeData(textTheme: const TextTheme()),
    );
  }
}

// extension CustomStyles on TextTheme {
//   TextStyle get error {
//     return TextStyle(
//       fontSize: 18.0,
//       color: Colors.red,
//       fontWeight: FontWeight.bold,
//     );
//   }
// }
