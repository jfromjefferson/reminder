import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/screens/routeScreen.dart';
import 'package:remind_me_of/services/local_notification.dart';
import 'package:remind_me_of/translations/messages.dart';
import 'package:remind_me_of/utils/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me_of/utils/registerAdapter.dart';

// Works when app is in background
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();

  await Firebase.initializeApp();
  await Hive.initFlutter();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  registerAdapter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: Locale('pt', 'BR'),
      fallbackLocale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      title: 'remind me',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: whiteColor
      ),
      home: RouteScreen(),
    );
  }
}
