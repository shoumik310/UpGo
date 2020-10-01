import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upgo/Screens/dataentry_screen.dart';
import 'package:upgo/Screens/home_screen.dart';
import 'package:upgo/Screens/login_screen.dart';
import 'package:upgo/Screens/signup_screen.dart';
import 'package:upgo/Screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

String initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = _auth.currentUser;
  initialRoute = user != null ? HomeScreen.id : WelcomeScreen.id;
  print(initialRoute);
  runApp(UpGo());
}

class UpGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
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
