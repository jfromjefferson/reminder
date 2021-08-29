import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remind_me_of/controllers/appController.dart';
import 'package:remind_me_of/utils/colors.dart';
import 'package:remind_me_of/widgets/customButton.dart';
import 'package:remind_me_of/widgets/customText.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/widgets/customTextField.dart';
import 'package:select_form_field/select_form_field.dart';

class NewReminderScreen extends StatelessWidget {
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    text: 'new_reminder_title'.tr,
                    size: 30,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(height: 20),
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
                  Row(
                    children: [
                      Expanded(
                        child: DateTimePicker(
                          type: DateTimePickerType.dateTime,
                          dateMask: 'date_format'.tr,
                          initialValue: '',
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          icon: Icon(LineIcons.calendarCheck, size: 35, color: primaryColor),
                          dateLabelText: 'date_hour'.tr,
                          timeLabelText: 'hour'.tr,
                          onChanged: (val) {
                            print(val);
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          CustomText(text: 'repeat'.tr),
                          Obx(() => Switch(
                            onChanged: (bool value) {
                              appController.setRepeatReminder(value: value);
                            },
                            value: appController.repeatReminder.value,
                          )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SelectFormField(
                          icon: Icon(LineIcons.objectGroup, size: 35, color: primaryColor),
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
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          CustomText(text: 'clear'.tr),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(LineIcons.alternateUndo, size: 35, color: primaryColor),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  CustomButton(
                    onPressed: () {},
                    text: 'create'.tr,
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
