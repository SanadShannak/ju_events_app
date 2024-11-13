import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:ju_events_app/utilities/constants.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(children: [
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_3, color: Constants.darkGreen),
            hintText: "Enter your username",
            hintStyle: const TextStyle(
                color: Constants.placeHolderGrey,
                fontFamily: 'Roboto',
                fontSize: 15,
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon:
                const Icon(Icons.fingerprint, color: Constants.darkGreen),
            hintText: "Enter your password",
            hintStyle: const TextStyle(
                color: Constants.placeHolderGrey,
                fontFamily: 'Roboto',
                fontSize: 15,
                fontWeight: FontWeight.w400),
            suffixIcon: const Icon(
              Icons.remove_red_eye_sharp,
              color: Constants.darkGreen,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text("Forgot Password?",
                style: TextStyle(
                    fontFamily: 'Roboto', color: Constants.darkGreen)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        //START OF BUTTONS AREA
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            children: [
              SizedBox(
                width: 300,
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Constants.darkGreen.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ]),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.darkGreen,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0)))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('OR',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Constants.placeHolderGrey,
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3))
                  ]),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Image(
                            image:
                                AssetImage('lib/assets/logo/google_logo.png'),
                            height: size.height * .03,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            "Continue with Google",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Constants.darkGreen,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0)),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 128,
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 3))
                      ]),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Bootstrap.facebook,
                              color: Colors.blue[700],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Facebook",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0)),
                            padding: EdgeInsets.symmetric(horizontal: 16)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 128,
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 3))
                      ]),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Bootstrap.linkedin,
                              color: Colors.blue[700],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "LinkedIn",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0)),
                            padding: EdgeInsets.symmetric(horizontal: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    ));
  }
}
