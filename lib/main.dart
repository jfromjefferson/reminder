import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/screens/mainScreen.dart';
import 'package:remind_me_of/screens/routeScreen.dart';
import 'package:remind_me_of/translations/messages.dart';
import 'package:remind_me_of/utils/colors.dart';

void main() {
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
