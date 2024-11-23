import 'package:flutter/material.dart';
import 'package:temp_project/screens/authentication/login_page.dart';
import 'package:temp_project/screens/authentication/signup_page.dart';

void main() => runApp(const JUEvents());

class JUEvents extends StatelessWidget {
  const JUEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
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
