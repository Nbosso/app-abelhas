import 'package:app_abelhas/core/di/service_locator.dart' as di;
import 'package:app_abelhas/core/services/firebase_messaging_service.dart';
import 'package:app_abelhas/core/services/local_notification_service.dart';
import 'package:app_abelhas/core/theme/app_theme.dart';
import 'package:app_abelhas/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'firebase_options.dart'; // Import firebase_options.dart
// import 'package:firebase_core/firebase_core.dart'; // Import firebase_core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(
  //   firebaseMessagingBackgroundHandler,
  // );
  await LocalNotificationService.initialize();
  await dotenv.load(fileName: ".env");
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.buildTheme(false);
    return MaterialApp.router(
      title: 'BeeAlert',
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: appRouter,
    );
  }
}
