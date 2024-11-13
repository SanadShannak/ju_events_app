import 'package:flutter/material.dart';
import 'package:ju_events_app/screens/login/login_footer_widget.dart';
import 'package:ju_events_app/screens/login/login_form_widget.dart';
import 'package:ju_events_app/screens/login/login_screen_background_vector.dart';
import 'package:ju_events_app/screens/login/login_screen_uj_logo.dart';
import 'package:ju_events_app/screens/login/user_details_boxes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const BackgroundVectorShape(),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  UJWidget(size: size),
                  const SizedBox(
                    height: 30,
                  ),
                  const SignInHeading(),
                  LoginForm(size: size),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const LoginFooterWidget()
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
