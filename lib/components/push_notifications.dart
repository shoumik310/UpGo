import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {
  PushNotificationManager._();
  factory PushNotificationManager() => _instance;
  static final PushNotificationManager _instance = PushNotificationManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialised = false;

  Future<void> init() async {
    if (!_initialised) {
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialised = true;
    }
  }
}
