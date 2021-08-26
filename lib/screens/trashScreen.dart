import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remind_me_of/widgets/customButton.dart';
import 'package:remind_me_of/widgets/customText.dart';
import 'package:get/get.dart';

class TrashScreen extends StatelessWidget {
  const TrashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: 'trash_title'.tr,
                      size: 30,
                      weight: FontWeight.bold),
                  IconButton(
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor: Colors.white,
                          title: CustomText(text: 'delete_all'.tr),
                          content: CustomText(
                            text: 'Blá, Blá, Blá, Blá, Blá',
                          ),
                          actions: [
                            CustomButton(
                              onPressed: () {
                                Get.back();
                              },
                              text: 'yes'.tr,
                              padding: EdgeInsets.all(0),
                              buttonColor: Colors.blue,
                              textSize: 15,
                            ),
                            CustomButton(
                              onPressed: () {
                                Get.back();
                              },
                              text: 'not'.tr,
                              padding: EdgeInsets.all(0),
                              buttonColor: Colors.red,
                              textSize: 15,
                            )
                          ],
                        ),
                        barrierDismissible: false
                      );
                    },
                    icon: Icon(
                      LineIcons.trash,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0xff7ECCFF),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  CustomText(
                                      text: 'Reminder title',
                                      weight: FontWeight.bold),
                                  SizedBox(height: 5),
                                  CustomText(text: 'move_to_trash_date'.tr),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: (){},
                                        icon: Icon(LineIcons.trash),
                                      ),
                                      SizedBox(width: 10),
                                      IconButton(
                                        onPressed: (){},
                                        icon: Icon(LineIcons.trashRestore),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0xff7ECCFF),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  CustomText(
                                      text: 'Reminder title',
                                      weight: FontWeight.bold),
                                  SizedBox(height: 5),
                                  CustomText(text: 'move_to_trash_date'.tr),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: (){},
                                        icon: Icon(LineIcons.trash),
                                      ),
                                      SizedBox(width: 10),
                                      IconButton(
                                        onPressed: (){},
                                        icon: Icon(LineIcons.trashRestore),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0xff7ECCFF),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  CustomText(
                                      text: 'Reminder title',
                                      weight: FontWeight.bold),
                                  SizedBox(height: 5),
                                  CustomText(text: 'move_to_trash_date'.tr),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: (){},
                                        icon: Icon(LineIcons.trash),
                                      ),
                                      SizedBox(width: 10),
                                      IconButton(
                                        onPressed: (){},
                                        icon: Icon(LineIcons.trashRestore),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
