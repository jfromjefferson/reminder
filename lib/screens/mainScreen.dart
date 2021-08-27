import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/controllers/appController.dart';
import 'package:remind_me_of/widgets/customText.dart';

class MainScreen extends StatelessWidget {
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(text: 'title'.tr, size: 30, weight: FontWeight.bold),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    CustomText(text: 'Category'),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xff7ECCFF),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: [
                                  CustomText(
                                    text: 'Reminder title',
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 5),
                                  CustomText(text: 'Text exemple...'),
                                  SizedBox(height: 5),
                                  CustomText(
                                    text: 'Today, 3:30 PM',
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomText(text: 'General'),
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
                                  CustomText(text: 'Text exemple...'),
                                  SizedBox(height: 5),
                                  CustomText(
                                      text: 'Today, 3:30 PM',
                                      weight: FontWeight.bold),
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
                                  CustomText(text: 'Text exemple...'),
                                  SizedBox(height: 5),
                                  CustomText(
                                      text: 'Today, 3:30 PM',
                                      weight: FontWeight.bold),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
