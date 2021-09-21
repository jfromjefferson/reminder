import 'package:admob_flutter/admob_flutter.dart';
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
import 'package:remind_me_of/widgets/futureAds.dart';
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
      if(widget.reminder!.reminderDate.isBefore(DateTime.now())){
        widget.reminder!.reminderDate = widget.reminder!.reminderDate.add(Duration(days: 1));
      }

      titleController..text = widget.reminder!.title;
      contentController..text = widget.reminder!.content!;
      dueDateController..text = widget.reminder!.reminderDate.toString();
      categoryController..text = widget.reminder!.category!;
      repeatController..text = widget.reminder!.repeat!;

      appController.selectedColor = widget.reminder!.color;
      appController.reminderTitle = widget.reminder!.title;
      appController.reminderContent = widget.reminder!.content!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: this.widget.reminder == null ? true : false,
      child: GestureDetector(
        onTap: () {FocusScope.of(context).unfocus();},
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
                        text: widget.reminder == null ? 'new_reminder_title'.tr : 'edit_reminder_title'.tr,
                        size: 30,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: titleController,
                        onChanged: (String value) {
                          appController.reminderTitle = value;
                        },
                        hintText: 'reminder_input_title'.tr,
                        textColor: Colors.black,
                        filled: false,
                        size: 23,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: 5),
                      CustomTextField(
                        controller: contentController,
                        onChanged: (String value) {
                          appController.reminderContent = value;
                        },
                        hintText: 'reminder_input_content'.tr,
                        textColor: Colors.black,
                        maxLines: 5,
                        filled: false,
                      ),
                      Divider(color: Colors.grey),
                      CustomText(text: 'show_colorpicker'.tr, size: 18),
                      SizedBox(height: 10),
                      ColorPicker(
                        color: Color(appController.selectedColor),
                        padding: EdgeInsets.zero,
                        enableShadesSelection: false,
                        pickersEnabled: {ColorPickerType.accent: false},
                        onColorChanged: (Color color){
                          appController.selectedColor = color.value;
                        },
                      ),
                      FutureAds(size: AdmobBannerSize.FULL_BANNER, settings: appController.settings),
                    ],
                  );
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Get.focusScope!.unfocus();
              Get.dialog(
                GestureDetector(
                  onTap: (){
                    Get.focusScope!.unfocus();
                  },
                  child: AlertDialog(
                      backgroundColor: Colors.white,
                      title: CustomText(text: 'define_time'.tr),
                      content: Container(
                        height: 230,
                        child: Column(
                          children: [
                            Flexible(
                              child: DateTimePicker(
                                icon: Icon(LineIcons.calendar, size: 30, color: primaryColor),
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
                            SizedBox(height: 10),
                            Flexible(
                              child: SelectFormField(
                                icon: Icon(LineIcons.list, size: 30, color: primaryColor),
                                controller: categoryController,
                                type: SelectFormFieldType.dropdown,
                                // or can be dialog
                                labelText: 'category'.tr,
                                items: appController.categoryDropList,
                                onChanged: (val) {},
                                onSaved: (val) => {},
                              ),
                            ),
                            SizedBox(height: 10),
                            Flexible(
                              child: SelectFormField(
                                controller: repeatController,
                                icon: Icon(LineIcons.syncIcon, size: 30, color: primaryColor),
                                type: SelectFormFieldType.dropdown,
                                labelText: 'repeat'.tr,
                                items: [
                                  {'value': 'once_a_day', 'label': 'once_a_day'.tr},
                                  {'value': 'once_a_week', 'label': 'once_a_week'.tr},
                                  {'value': 'not_repeat', 'label': 'not_repeat'.tr},
                                ],
                                onChanged: (val) => {},
                                onSaved: (val) => {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        CustomButton(
                          onPressed: (){
                            String title = appController.reminderTitle;
                            String content = appController.reminderContent;
                            String dueDate = dueDateController.text;
                            String category = categoryController.text;
                            String repeat = repeatController.text;

                            if(widget.reminder == null){
                              appController.newReminder(
                                  title: title,
                                  dueDate: dueDate,
                                  repeat: repeat,
                                  category: category,
                                  content: content,
                                  color: appController.selectedColor
                              );
                            }else{
                              appController.updReminder(
                                title: title,
                                dueDate: dueDate,
                                repeat: repeat,
                                category: category,
                                content: content,
                                color: appController.selectedColor,
                                key: widget.reminder!.key
                              );
                            }

                            appController.reminderTitle = '';
                            appController.reminderContent = '';
                            appController.clearField(controller: titleController);
                            appController.clearField(controller: contentController);
                            appController.clearField(controller: dueDateController);
                            appController.clearField(controller: categoryController);
                            appController.clearField(controller: repeatController);
                            appController.selectedColor = primaryColor.value;
                          },
                          text: 'yes'.tr,
                          padding: EdgeInsets.all(0),
                          buttonColor: primaryColor,
                          textSize: 15,
                        ),
                        CustomButton(
                          onPressed: (){
                            Get.back();
                          },
                          text: 'back'.tr,
                          padding: EdgeInsets.all(0),
                          buttonColor: Colors.grey,
                          textSize: 15,
                        ),
                      ],
                    ),
                ),
                barrierDismissible: false,
              );
            },
            child: Icon(widget.reminder == null ? LineIcons.check : LineIcons.alternatePencil),
            backgroundColor: primaryColor,
          ),
        ),
      ),
    );
  }
}
