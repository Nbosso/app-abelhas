import 'dart:developer';

import 'package:app_abelhas/core/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class AbstractFirebaseMessagingService {
  Future<String?> initialize();

  void setUpOnMessage();
  void setUpOnMessageOpenedApp();
  Future<String?> getFirebaseToken();
  Future<void> deleteFirebaseToken();
}

class FirebaseMessagingService extends AbstractFirebaseMessagingService {
  FirebaseMessagingService();

  @override
  Future<String?> initialize() async {
    await FirebaseMessaging.instance.requestPermission();
    final firebaseToken = await getFirebaseToken();
    setUpOnMessage();
    setUpOnMessageOpenedApp();
    return firebaseToken;
  }

  @override
  void setUpOnMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('New notification');
      // 1️⃣ Chama o callback (ex: Cubit / Provider / Navegação)
      // callbackFunctionOnMessage(message);

      // 2️⃣ Mostra notificação local no foreground
      final title =
          message.notification?.title ?? message.data['title'] ?? 'Alerta';

      final body = message.notification?.body ?? message.data['body'] ?? '';

      LocalNotificationService.show(
        title: title,
        body: body,
      );
    });
  }

  @override
  void setUpOnMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Message: ${message}');
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      log('Initial Message: ${message?.notification?.title ?? '--'}');
    });
  }

  @override
  Future<String?> getFirebaseToken() async {
    final firebaseToken = await FirebaseMessaging.instance.getToken();
    log("Firebase TOKEN: $firebaseToken");
    return firebaseToken;
  }

  @override
  Future<void> deleteFirebaseToken() async {
    await FirebaseMessaging.instance.deleteToken();
    return;
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('🔔 Background message: ${message.messageId}');
}
