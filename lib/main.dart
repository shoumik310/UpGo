import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upgo/Screens/dataentry_screen.dart';
import 'package:upgo/Screens/home_screen.dart';
import 'package:upgo/Screens/login_screen.dart';
import 'package:upgo/Screens/signup_screen.dart';
import 'package:upgo/Screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';

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

class UpGo extends StatefulWidget {
  @override
  _UpGoState createState() => _UpGoState();
}

class _UpGoState extends State<UpGo> {
  String _message = '';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) => _update(token));
  }

  _update(String token) {
    print(token);
    DatabaseReference _databaseReference =
        FirebaseDatabase.instance.reference();
    _databaseReference.child('fcm-token/$token').set({"token": token});
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
    _register();
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text(message['notification']['title']),
            subtitle: Text(message['notification']['body']),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["title"]);
    });
  }

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
