import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp_project/providers/data_collection_provider.dart';
import 'package:temp_project/screens/event_request_create_pages/event_provider.dart';
import 'package:temp_project/screens/event_request_create_pages/event_request_create_pages.dart';
import 'package:temp_project/services/database_service/database_service.dart';
import 'package:temp_project/services/database_service/extensions/user_extensions.dart';
import 'package:temp_project/utilities/constants.dart';
import 'package:temp_project/utilities/theme/theme.dart';

import 'firebase_options.dart';
import 'models/user.dart';
import 'models/user_roles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataCollectionProvider())
      ],
      child: const JUEvents(),
    ),
  );
}

class JUEvents extends StatelessWidget {
  const JUEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: DatabaseService().areUserDetailsFilled(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: AppColors.kBackground,
            child: Center(
              child: Image.asset(
                'lib/assets/images/JE_Events_logo/logo.png',
                width: 200,
                height: 200,
              ),
            ),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            themeMode: ThemeMode.light,
            initialRoute: AuthService.instance.isUserLoggedIn()
                ? (areDetailsFilled ? '/' : '/greetingPage')
                : '/landingPage',
            routes: {
              '/landingPage': (context) => const LandingPage(),
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignUpPage(),
              '/nameCollection': (context) => NameCollectionPage(),
              '/greetingPage': (context) => const GreetingPage(),
              '/dataCollectionPages': (context) =>
                  const DataCollectionNavigation(),
              '/': (context) => const MainBottomNavigationBar(),
              '/dataCollectionNavigation': (context) =>
                  const DataCollectionNavigation(),
            },
          );
        }
      },
    );
  }
}
