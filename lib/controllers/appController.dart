import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/database/models/category/category.dart';
import 'package:remind_me_of/database/models/reminder/reminder.dart';
import 'package:remind_me_of/database/queries/category/category.dart';
import 'package:remind_me_of/database/queries/reminder/reminder.dart';
import 'package:remind_me_of/screens/newReminderScreen.dart';
import 'package:remind_me_of/screens/routeScreen.dart';
import 'package:remind_me_of/utils/colors.dart';
import 'package:remind_me_of/utils/functions.dart';
import 'package:remind_me_of/widgets/customText.dart';

class AppController extends GetxController {
  var categoryList = [].obs;
  List<Map<String, dynamic>> categoryDropList = [];

  var categoryNameToEdit = ''.obs;
  String reminderTitle = '';
  String reminderContent = '';

  var showColorPicker = false.obs;
  int selectedColor = primaryColor.value;

  late Reminder reminderToEdit;

  @override
  void onInit() async {
    List<Category> categoryResponse = await getCategoryList();
    categoryList.value = categoryResponse;

    categoryDropList = await setCategoryDropdown();

    super.onInit();
  }

  void toggleColorPicker({required bool value}){
    showColorPicker.value = value;
  }

  Future<void> newReminder({required String title, String ?content, required String dueDate, String ?category, String ?repeat, required int color}) async {
    if(title.isNotEmpty && dueDate.isNotEmpty){
      Reminder reminder = Reminder(
        title: title,
        content: content,
        reminderDate: DateTime.parse(dueDate),
        category: category,
        repeat: repeat,
        color: color
      );

      await createReminder(reminder: reminder);
      Get.snackbar(
          'reminder_success_title'.tr,
          'reminder_success_message'.tr,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.only(top: 10, left: 5, right: 5)
      );
    }else{
      Get.snackbar(
          'reminder_error_title'.tr,
          'reminder_error_message'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.only(top: 10, left: 5, right: 5)
      );
    }
  }

  Future<void> categoryConfig({required String categoryName}) async {
    if (categoryName.isNotEmpty) {
      Category category = Category(name: categoryName);

      await createCategory(category: category);
      categoryList.value = await getCategoryList();
      categoryDropList = await setCategoryDropdown();
      update();
      Get.back();
    }else{
      Get.snackbar(
          'category_error_title'.tr,
          'category_error_message'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.only(top: 10, left: 5, right: 5)
      );
    }
  }

  Future<void> delCategory({required int index}) async {
    await deleteCategory(index: index);
    categoryList.value = await getCategoryList();
    categoryDropList = await setCategoryDropdown();
    update();
  }

  Future<void> updCategory({required String categoryName, required int index}) async {
    if(categoryName.isNotEmpty){
      Category category = Category(name: categoryName);
      await updateCategory(category: category, index: index);
      categoryList.value = await getCategoryList();
      categoryDropList = await setCategoryDropdown();
      update();
      Get.back();
    }else{
      Get.snackbar(
          'category_error_title'.tr,
          'category_error_message'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.only(top: 10, left: 5, right: 5)
      );
    }
  }

  void clearField({required TextEditingController controller}){
    controller..text = '';
    Get.focusScope!.unfocus();
    update();
  }

  Future<List<Map<String, dynamic>>> setCategoryDropdown() async {
    List<Category> response = await getCategoryList();
    List<Map<String, dynamic>> list = [];

    response.forEach((element) {
      list.add({
        'value': element.name,
        'label': element.name
      });
    });

    return list;
  }

  Future<List<Widget>> createReminderList() async {
    List<Widget> widgetList = [];

    List<Reminder> reminderResponse = await getReminderList();

    reminderResponse.forEach((reminder) {
      Color textColor = Color(reminder.color).computeLuminance() > 0.5 ? Colors.black : Colors.white;

      widgetList.add(
          GestureDetector(
            onTap: (){
              Get.to(() => NewReminderScreen(reminder: reminder), transition: Transition.cupertino);
            },
            child: Container(
              width: Get.mediaQuery.size.width/2.2,
              height: Get.mediaQuery.size.width/2.5,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                color: Color(reminder.color),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    text: reminder.title,
                    weight: FontWeight.bold,
                    color: textColor,
                    align: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Flexible(child: CustomText(text: reminder.content ?? '', color: textColor, align: TextAlign.center,
                  )),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(3)
                    ),
                    child: CustomText(
                      text: formatDate(date: reminder.reminderDate, repeat: reminder.repeat),
                      weight: FontWeight.bold,
                      color: textColor,
                      size: 13,
                      align: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          )
      );
    });

    return widgetList;
  }

}
