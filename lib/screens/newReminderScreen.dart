import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remind_me_of/controllers/appController.dart';
import 'package:remind_me_of/database/models/reminder/reminder.dart';
import 'package:remind_me_of/utils/colors.dart';
import 'package:remind_me_of/widgets/customButton.dart';
import 'package:remind_me_of/widgets/customText.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/widgets/customTextField.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class NewReminderScreen extends StatefulWidget {

  final Reminder ?reminder;

  NewReminderScreen({this.reminder});

  @override
  _NewReminderScreenState createState() => _NewReminderScreenState();
}

class _NewReminderScreenState extends State<NewReminderScreen> {
  final AppController appController = Get.find();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController repeatController = TextEditingController();

  @override
  void initState() {
    if(widget.reminder != null){
      titleController..text = widget.reminder!.title;
      contentController..text = widget.reminder!.content!;
      dueDateController..text = widget.reminder!.reminderDate.toString();
      categoryController..text = widget.reminder!.category!;
      repeatController..text = widget.reminder!.repeat!;
      appController.selectedColor = widget.reminder!.color;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: this.widget.reminder == null ? true : false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: this.widget.reminder == null
              ? null
              : AppBar(title: CustomText(text: 'back'.tr), backgroundColor: Color(widget.reminder!.color)),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: GetBuilder<AppController>(
                builder: (_){
                  return Column(
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
                        controller: titleController,
                        onChanged: (String value) {
                          appController.reminderTitle = value;
                        },
                        hintText: 'reminder_input_title'.tr,
                        textColor: Colors.black,
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        controller: contentController,
                        onChanged: (String value) {
                          appController.reminderContent = value;
                        },
                        hintText: 'reminder_input_content'.tr,
                        textColor: Colors.black,
                        maxLines: 3,
                      ),
                      SizedBox(height: 15),
                      Obx(() => Column(
                        children: [
                          Column(
                            children: [
                              CustomText(text: 'show_colorpicker'.tr),
                              Switch(
                                onChanged: (bool value){
                                  appController.toggleColorPicker(value: value);
                                },
                                value: appController.showColorPicker.value,
                              )
                            ],
                          ),
                          appController.showColorPicker.value ?
                          ColorPicker(
                            onColorChanged: (Color color){
                              appController.selectedColor = color.value;
                            },
                          )
                              : SizedBox(),
                        ],
                      )),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            child: DateTimePicker(
                              controller: dueDateController,
                              type: DateTimePickerType.dateTime,
                              initialDate: widget.reminder != null
                                  ? DateTime.parse(dueDateController.text)
                                  : DateTime.now(),
                              dateMask: 'date_format'.tr,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              dateLabelText: 'date_hour'.tr,
                              timeLabelText: 'hour'.tr,
                              onChanged: (String val) {},

                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              SizedBox(height: 10),
                              IconButton(
                                onPressed: (){
                                  appController.clearField(controller: dueDateController);
                                },
                                icon: Icon(LineIcons.timesCircle, size: 35, color: primaryColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            child: SelectFormField(
                              controller: categoryController,
                              type: SelectFormFieldType.dropdown,
                              // or can be dialog
                              labelText: 'category'.tr,
                              items: appController.categoryDropList,
                              onChanged: (val) {},
                              onSaved: (val) => {},
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              SizedBox(height: 10),
                              IconButton(
                                onPressed: (){
                                  appController.clearField(controller: categoryController);
                                },
                                icon: Icon(LineIcons.timesCircle, size: 35, color: primaryColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            child: SelectFormField(
                              controller: repeatController,
                              type: SelectFormFieldType.dropdown,
                              labelText: 'repeat'.tr,
                              items: [
                                {
                                  'value': 'once_a_day',
                                  'label': 'Once a day',
                                },
                                {
                                  'value': 'once_a_week',
                                  'label': 'Once a week',
                                },
                                {
                                  'value': 'once_a_month',
                                  'label': 'Once a month',
                                },
                              ],
                              onChanged: (val) => {},
                              onSaved: (val) => {},
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              SizedBox(height: 10),
                              IconButton(
                                onPressed: (){
                                  appController.clearField(controller: repeatController);
                                },
                                icon: Icon(LineIcons.timesCircle, size: 35, color: primaryColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 50),
                      CustomButton(
                        onPressed: () {
                          String title = appController.reminderTitle;
                          String content = appController.reminderContent;
                          String dueDate = dueDateController.text;
                          String category = categoryController.text;
                          String repeat = repeatController.text;

                          appController.newReminder(
                            title: title,
                            dueDate: dueDate,
                            repeat: repeat,
                            category: category,
                            content: content,
                            color: appController.selectedColor
                          );

                          appController.reminderTitle = '';
                          appController.reminderContent = '';
                          appController.clearField(controller: titleController);
                          appController.clearField(controller: contentController);
                          appController.clearField(controller: dueDateController);
                          appController.clearField(controller: categoryController);
                          appController.clearField(controller: repeatController);
                          appController.showColorPicker.value = false;
                          appController.selectedColor = primaryColor.value;
                        },
                        text: 'create'.tr,
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
