import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remind_me_of/screens/categoryListScreen.dart';
import 'package:remind_me_of/utils/colors.dart';
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
                        GestureDetector(
                          onTap: (){},
                          child: ListTile(
                            leading: Icon(LineIcons.user, size: 35, color: primaryColor),
                            title: CustomText(text: 'profile'.tr, size: 18),
                            subtitle: CustomText(text: 'profile_sub'.tr, size: 12),
                            trailing: Icon(LineIcons.arrowRight, size: 30, color: primaryColor),
                          ),
                        ),
                        Divider(color: Colors.grey),
                        GestureDetector(
                          onTap: (){
                            Get.to(() => CategoryListScreen(), transition: Transition.cupertino);
                          },
                          child: ListTile(
                            leading: Icon(LineIcons.list, size: 35, color: primaryColor),
                            title: CustomText(text: 'categories'.tr, size: 18),
                            subtitle: CustomText(text: 'categories_sub'.tr, size: 12),
                            trailing: Icon(LineIcons.arrowRight, size: 30, color: primaryColor),
                          ),
                        ),
                        Divider(color: Colors.grey)
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
