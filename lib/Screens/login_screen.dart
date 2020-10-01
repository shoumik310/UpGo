import 'package:flutter/material.dart';
import 'package:upgo/Screens/dataentry_screen.dart';
import 'package:upgo/Screens/home_screen.dart';
import 'package:upgo/data.dart';
import '../components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo1.jpg'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _email = value;
                },
                //Todo: decoration: ,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _password = value;
                },
                //Todo: decoration: ,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    if (user != null) {
                      print(_email);
                      print(_password);
                      final prefs = await SharedPreferences.getInstance();
                      print(prefs.getString('email'));
                      if (prefs.getString('name') == null ||
                          prefs.getString('email') != _email) {
                        prefs.clear();
                        prefs.setString('email', _email);
                        Navigator.pushNamed(context, DataEntryScreen.id);
                      } else {
                        Navigator.pushNamed(context, HomeScreen.id);
                      }
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text(e.toString()),
                          );
                        });
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
