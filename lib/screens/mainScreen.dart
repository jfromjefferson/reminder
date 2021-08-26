import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remind_me_of/utils/colors.dart';
import 'package:remind_me_of/widgets/customButton.dart';
import 'package:remind_me_of/widgets/customText.dart';
import 'package:remind_me_of/widgets/customTextField.dart';
import 'package:select_form_field/select_form_field.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                      text: 'new_reminder_title'.tr,
                      size: 22,
                      align: TextAlign.center),
                  SizedBox(height: 15),
                  CustomTextField(
                    onChanged: (String value) {},
                    hintText: 'reminder_input_title'.tr,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    onChanged: (String value) {},
                    hintText: 'reminder_input_content'.tr,
                    textColor: Colors.black,
                    maxLines: 3,
                  ),
                  SizedBox(height: 15),
                  DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'date_format'.tr,
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event, size: 35, color: primaryColor),
                    dateLabelText: 'date'.tr,
                    timeLabelText: 'hour'.tr,
                    onChanged: (val) {
                      print(val);
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Column(
                        children: [
                          CustomText(text: 'repeat'.tr),
                          SizedBox(height: 5),
                          Switch(
                            value: false,
                            onChanged: (bool value) {},
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: SelectFormField(
                          type: SelectFormFieldType.dropdown,
                          // or can be dialog
                          initialValue: 'circle',
                          labelText: 'category'.tr,
                          items: [
                            {
                              'value': 'boxValue',
                              'label': 'Box Label',
                              'icon': Icon(Icons.stop),
                            },
                            {
                              'value': 'circleValue',
                              'label': 'Circle Label',
                              'icon': Icon(Icons.fiber_manual_record),
                              'textStyle': TextStyle(color: Colors.red),
                            },
                          ],
                          onChanged: (val) => print(val),
                          onSaved: (val) => print(val),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    onPressed: () {},
                    text: 'create'.tr,
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ],
              ),
            ),
          ));
        },
        child: Icon(LineIcons.plus, size: 25),
        backgroundColor: primaryColor,
      ),
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
