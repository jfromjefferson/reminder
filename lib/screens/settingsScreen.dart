import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remind_me_of/widgets/customText.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(text: 'settings_title'.tr, size: 30, weight: FontWeight.bold),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        ListTile(
                          leading: Icon(LineIcons.user, size: 35),
                          title: CustomText(text: 'profile'.tr, size: 18),
                          subtitle: CustomText(text: 'profile_sub'.tr, size: 12),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 0,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
