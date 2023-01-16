//SHA1 - 02:90:6E:5F:51:59:97:A5:4A:9F:45:27:F0:B1:6A:E8:96:3A:62:20

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream =
      StreamController.broadcast();

  static Stream<String> get messageStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    // print('onBackground handler ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No Title');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print('onMessage handler ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No Title');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print('onMessageOpenApp handler ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No Title');
  }

  static Future initializeApp() async {
    //Push Notificacion
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Este es el token $token');
    //handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStream() {
    _messageStream.close();
  }
}
