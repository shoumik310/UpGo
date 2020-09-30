import 'package:flutter/material.dart';
import 'package:upgo/Screens/dataentry_screen.dart';
import 'package:upgo/Screens/home_screen.dart';
import 'package:upgo/Screens/login_screen.dart';
import 'package:upgo/Screens/signup_screen.dart';
import 'package:upgo/Screens/welcome_screen.dart';
import 'package:upgo/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(UpGo());
}

class UpGo extends StatefulWidget {
  @override
  _UpGoState createState() => _UpGoState();
}

class _UpGoState extends State<UpGo> {
  static bool checkSignIn;
  getSignInStatus() async {
    SharedPreferences _data = await SharedPreferences.getInstance();
    checkSignIn = _data.containsKey('accountStatus');
  }

  @override
  void initState() {
    getSignInStatus();
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: checkSignIn ? WelcomeScreen.id : HomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        DataEntryScreen.id: (context) => DataEntryScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
