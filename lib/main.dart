import 'package:flutter/material.dart';
import 'package:upgo/Screens/DataEntryScreen.dart';
import 'package:upgo/Screens/HomeScreen.dart';
import 'package:upgo/Screens/login_screen.dart';
import 'package:upgo/Screens/SignupScreen.dart';
import 'package:upgo/Screens/WelcomeScreen.dart';

void main() {
  runApp(UpGo());
}

class UpGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
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
