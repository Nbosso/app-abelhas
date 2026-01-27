import 'dart:developer';

import 'package:app_abelhas/core/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class AbstractFirebaseMessagingService {
  Future<String?> initialize();

  void setUpOnMessage(
      {required Function(RemoteMessage? remoteMessage)
          callbackFunctionOnMessage});
  void setUpOnMessageOpenedApp(
      {required Function(RemoteMessage? remoteMessage)
          callbackFunctionOnMessageOpenedApp});
  Future<String?> getFirebaseToken();
  Future<void> deleteFirebaseToken();
}

class FirebaseMessagingService extends AbstractFirebaseMessagingService {
  FirebaseMessagingService();

  @override
  Future<String?> initialize() async {
    await FirebaseMessaging.instance.requestPermission();
    final firebaseToken = await getFirebaseToken();
    return firebaseToken;
  }

  @override
  void setUpOnMessage({
    required Function(RemoteMessage message) callbackFunctionOnMessage,
  }) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // 1️⃣ Chama o callback (ex: Cubit / Provider / Navegação)
      callbackFunctionOnMessage(message);

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
  void setUpOnMessageOpenedApp(
      {required Function(RemoteMessage? remoteMessage)
          callbackFunctionOnMessageOpenedApp}) {
    FirebaseMessaging.onMessageOpenedApp
        .listen(callbackFunctionOnMessageOpenedApp);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((message) => callbackFunctionOnMessageOpenedApp(message));
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
