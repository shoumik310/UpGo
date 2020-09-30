import 'package:flutter/material.dart';
import 'package:upgo/Screens/DataEntryScreen.dart';
import '../Screens/login_screen.dart';
import 'SignupScreen.dart';
import '../components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo1.jpg'),
                    height: 60.0,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'UpGo',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, DataEntryScreen.id);
              },
            ),
            RoundedButton(
              title: 'Sign In',
              colour: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, SignupScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
