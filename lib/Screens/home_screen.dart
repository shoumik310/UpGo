import 'package:flutter/material.dart';
import 'package:upgo/Screens/welcome_screen.dart';
import 'package:upgo/components/future_list.dart';
import 'package:upgo/data.dart';
import '../components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/futurecard.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Here are all your details'),
                Expanded(child: FutureCard(getData: getName)),
                Expanded(child: FutureCard(getData: getAadhar)),
                Expanded(child: FutureCard(getData: getBlood)),
                Expanded(
                    child: FutureCard(
                  getData: getDate,
                  isBirthDate: true,
                )),
                Expanded(child: FutureList(getConditions)),
                RoundedButton(
                  title: 'Log out',
                  colour: Colors.red,
                  onPressed: () async {
                    FirebaseAuth _auth = FirebaseAuth.instance;
                    await _auth.signOut();
                    Navigator.pushNamedAndRemoveUntil(context, WelcomeScreen.id,
                        (Route<dynamic> route) => false);
                  },
                )
              ],
            ),
          )),
    );
  }
}
