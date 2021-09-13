import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/controllers/appController.dart';
import 'package:remind_me_of/screens/routeScreen.dart';
import 'package:remind_me_of/services/local_notification.dart';
import 'package:remind_me_of/translations/messages.dart';
import 'package:remind_me_of/utils/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me_of/utils/registerAdapter.dart';
import 'package:admob_flutter/admob_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  await LocalNotificationService.initialize();

  await Hive.initFlutter();

  registerAdapter();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppController appController = Get.put(AppController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: Locale(appController.settings.languageCode),
      fallbackLocale: Locale('pt_BR'),
      debugShowCheckedModeBanner: false,
      title: 'remind me',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: whiteColor
      ),
      home: RouteScreen(),
    );
  }
}
