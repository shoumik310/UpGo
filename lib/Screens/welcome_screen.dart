import 'package:flutter/material.dart';
import '../Screens/login_screen.dart';
import 'signup_screen.dart';
import '../components/rounded_button.dart';
import 'package:upgo/constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('images/logo2.png'),
                height: 300.0,
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            RoundedButton(
              title: 'Log In',
              buttonColour: Colors.white,
              textColour: kBackgroundColor,
              borderColour: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Sign Up',
              buttonColour: kBackgroundColor,
              textColour: Colors.white,
              borderColour: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, SignupScreen.id);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 20 / 100,
            )
          ],
        ),
      ),
    );
  }
}
