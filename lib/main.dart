import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp_project/providers/data_collection_provider.dart';
import 'package:temp_project/screens/authentication/landing_page.dart';
import 'package:temp_project/screens/authentication/login_page.dart';
import 'package:temp_project/screens/authentication/signup_page.dart';
import 'package:temp_project/screens/dataCollectionNavigation/components/data_collection_navigation_widget.dart';
import 'package:temp_project/screens/dataCollectionNavigation/components/greeting_page.dart';
import 'package:temp_project/screens/dataCollectionNavigation/name_collection.dart';
import 'package:temp_project/services/auth_service.dart';
import 'package:temp_project/services/database_service/database_service.dart';
import 'package:temp_project/services/database_service/extensions/user_extensions.dart';
import 'package:temp_project/utilities/constants.dart';
import 'package:temp_project/utilities/theme/theme.dart';
import 'package:temp_project/widgets/bottom_navigation_bar.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DataCollectionProvider())],
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
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: AppColors.kDarkGreen,
              ),
            ),
          );
        } else {
          final bool areDetailsFilled = snapshot.data ?? false;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            themeMode: ThemeMode.light,
            initialRoute:
                AuthService.instance.isUserLoggedIn() ? (areDetailsFilled ? '/mainPages' : '/greetingPage') : '/',
            routes: {
              '/': (context) => const LandingPage(),
              '/login': (context) => LoginPage(),
              '/signup': (context) => SignUpPage(),
              '/nameCollection': (context) => NameCollectionPage(),
              '/greetingPage': (context) => const GreetingPage(),
              '/dataCollectionPages': (context) => DataCollectionNavigation(),
              '/mainPages': (context) => const MainBottomNavigationBar(),
              '/dataCollectionNavigation': (context) => DataCollectionNavigation(),
            },
          );
        }
      },
    );
  }
}
