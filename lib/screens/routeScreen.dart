import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remind_me_of/screens/mainScreen.dart';
import 'package:remind_me_of/screens/settingsScreen.dart';
import 'package:remind_me_of/screens/trashScreen.dart';
import 'package:remind_me_of/utils/colors.dart';

class RouteScreen extends StatefulWidget {

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  int pageIndex = 1;

  List<Widget> pageList = [
    SettingsScreen(),
    MainScreen(),
    TrashScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        height: 50,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.black12,
        color: Colors.black12,
        items: [
          Icon(LineIcons.userCog, color: Colors.black),
          Icon(LineIcons.plus, color: Colors.black),
          Icon(LineIcons.trash, color: Colors.black),
        ],
        onTap: (int index){
          setState(() {
            pageIndex = index;
          });
        },
      ),
      body: pageList[pageIndex],
    );
  }
}