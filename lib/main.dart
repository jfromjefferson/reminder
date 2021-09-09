import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/screens/routeScreen.dart';
import 'package:remind_me_of/services/local_notification.dart';
import 'package:remind_me_of/translations/messages.dart';
import 'package:remind_me_of/utils/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me_of/utils/registerAdapter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.initialize();

  await Hive.initFlutter();

  registerAdapter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: Locale('pt_BR'),
      fallbackLocale: Locale('en_US'),
      debugShowCheckedModeBanner: false,
      title: 'remind me',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: whiteColor
      ),
      home: RouteScreen(),
    );
  }
}
