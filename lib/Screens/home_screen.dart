import 'package:flutter/material.dart';
import 'package:upgo/Screens/welcome_screen.dart';
import 'package:upgo/components/future_list.dart';
import 'package:upgo/data.dart';
import '../components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/futurecard.dart';
import '../constants.dart';
import 'package:bordered_text/bordered_text.dart';

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
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Icon(
                Icons.turned_in,
                size: 40,
              ),
            ),
            backgroundColor: kBackgroundColor,
            title: BorderedText(
              strokeWidth: 5,
              strokeColor: Colors.white,
              child: Text(
                'Here are all your crucial details',
                style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor),
              ),
            ),
          ),
          backgroundColor: kBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Name: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.bold),
                    ),
                    FutureCard(getData: getName),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Aadhar Card No.: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.bold),
                    ),
                    FutureCard(getData: getAadhar),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Blood Type: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.bold),
                    ),
                    FutureCard(getData: getBlood),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Age: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.bold),
                    ),
                    FutureCard(
                      getData: getDate,
                      isBirthDate: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Known Conditions: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'PlayfairDisplay',
                      fontWeight: FontWeight.bold),
                ),
                Expanded(child: FutureList(getConditions)),
                RoundedButton(
                  buttonColour: kBackgroundColor,
                  textColour: Colors.white,
                  borderColour: Colors.white,
                  title: 'Log out',
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
