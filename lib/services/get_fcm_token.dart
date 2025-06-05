import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  static Future<void> requestPermission() async {
    try {
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
          print('✅ User granted full permission');
          break;
        case AuthorizationStatus.provisional:
          print('ℹ️ User granted provisional permission');
          break;
        case AuthorizationStatus.denied:
          print('❌ User denied permission');
          break;
        default:
          print('⚠️ Unknown permission status: ${settings.authorizationStatus}');
      }
    } catch (e) {
      print('🔥 Error requesting notification permissions: $e');
    }
  }

  static Future<String?> getFCMToken() async {
    try {
      String? fcmToken;
      if (Platform.isAndroid) {
        fcmToken = await FirebaseMessaging.instance.getToken();
      } else {
        fcmToken = await FirebaseMessaging.instance.getAPNSToken();
      }
      print("FCM Token: $fcmToken");
      return fcmToken;
    } catch (e) {
      print("Error getting FCM token: $e");
      return null;
    }
  }
}
