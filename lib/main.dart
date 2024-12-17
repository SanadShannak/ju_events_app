import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:temp_project/screens/authentication/landing_page.dart';
import 'package:temp_project/screens/authentication/login_page.dart';
import 'package:temp_project/screens/authentication/signup_page.dart';
import 'package:temp_project/screens/dataCollection/greeting_page.dart';
import 'package:temp_project/screens/dataCollection/name_collection.dart';
import 'package:temp_project/screens/homePage/home_page.dart';
import 'package:temp_project/services/auth_service.dart';
import 'package:temp_project/utilities/theme/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const JUEvents());
}

class JUEvents extends StatelessWidget {
  const JUEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: AuthService.instance.isUserLoggedIn() ? '/homepage' : '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/nameCollection': (context) => NameCollectionPage(),
        '/greetingPage': (context) => const GreetingPage(),
        '/homepage': (context) => const HomePage(),
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
