import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/database/models/category/category.dart';
import 'package:remind_me_of/database/models/reminder/reminder.dart';
import 'package:remind_me_of/database/models/settings/settings.dart';
import 'package:remind_me_of/database/queries/category/category.dart';
import 'package:remind_me_of/database/queries/reminder/reminder.dart';
import 'package:remind_me_of/database/queries/settings/settings.dart';
import 'package:remind_me_of/screens/newReminderScreen.dart';
import 'package:remind_me_of/services/local_notification.dart';
import 'package:remind_me_of/utils/colors.dart';
import 'package:remind_me_of/utils/functions.dart';
import 'package:remind_me_of/widgets/customButton.dart';
import 'package:remind_me_of/widgets/customText.dart';
import 'package:timezone/data/latest.dart' as tz;

class AppController extends GetxController {
  Settings settings = Settings(languageCode: 'en_US', deletePastReminders: true, showAds: true);
  var categoryList = [].obs;
  List<Map<String, dynamic>> categoryDropList = [];

  var categoryNameToEdit = ''.obs;
  String reminderTitle = '';
  String reminderContent = '';

  int selectedColor = primaryColor.value;

  late Reminder reminderToEdit;

  String selectedCategory = '';

  String selectedLanguageCode = '';
  var deleteOldReminders = true.obs;
  var removeAds = false.obs;

  @override
  void onInit() async {
    settings = await getSettings();
    selectedLanguageCode = settings.languageCode;
    deleteOldReminders.value = settings.deletePastReminders;
    removeAds.value = settings.showAds;

    Locale locale = Locale(settings.languageCode);
    Get.updateLocale(locale);

    tz.initializeTimeZones();

    List<Category> categoryResponse = await getCategoryList();
    categoryList.value = categoryResponse;

    categoryDropList = await setCategoryDropdown();
    
    super.onInit();
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
      await LocalNotificationService.schedule(reminder: reminder);

      Get.back();
      alert(title: 'reminder_success_title', message: 'reminder_success_message'.tr);
    }else{
      Get.back();
      alert(title: 'reminder_error_title', message: 'reminder_error_message'.tr);
    }
  }

  Future<void> delReminder({required int key}) async {
    await deleteReminder(key: key);
    await LocalNotificationService.cancelNotification(id: key);

    alert(title: 'delete_reminder_success_title', message: 'delete_reminder_success_message');

    update();
  }

  Future<void> updReminder({required String title, String ?content, required String dueDate, String ?category, String ?repeat, required int color, required int key}) async {
    if(title.isNotEmpty && dueDate.isNotEmpty) {
      Reminder reminder = Reminder(
          title: title,
          content: content,
          reminderDate: DateTime.parse(dueDate),
          category: category,
          repeat: repeat,
          color: color
      );

      await updateReminder(reminder: reminder, key: key);

      await LocalNotificationService.cancelNotification(id: key);
      await LocalNotificationService.schedule(reminder: reminder);

      Get.back();
      alert(title: 'update_reminder_success_title', message: 'update_reminder_success_message');

      update();
    }else{

      alert(title: 'reminder_error_title', message: 'reminder_error_message');
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
      alert(title: 'category_success_title', message: 'category_success_message');
    }else{

      alert(title: 'category_error_title', message: 'category_error_message');
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
      alert(title: 'category_success_title', message: 'category_update_success_message');
    }else{

      alert(title: 'category_error_title', message: 'category_error_message');
    }
  }

  void clearField({required TextEditingController controller}){
    controller..text = '';
    Get.focusScope!.unfocus();
    update();
  }

  void setCategoryFilter({required String category}){
    selectedCategory = category;
    update();
    Get.back();
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

    List<Reminder> reminderResponse = await getReminderList(category: selectedCategory);

    reminderResponse.forEach((reminder) async {
      Color textColor = Color(reminder.color).computeLuminance() > 0.5 ? Colors.black : Colors.white;

      widgetList.add(
          GestureDetector(
            onLongPress: (){
              Get.to(() => NewReminderScreen(reminder: reminder), transition: Transition.cupertino);
            },
            onTap: (){
              Get.bottomSheet(
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomText(
                              text: reminder.title,
                              size: 22,
                              weight: FontWeight.bold,
                              align: TextAlign.center
                          ),
                          SizedBox(height: 15),
                          CustomText(text: reminder.content ?? '', size: 19),
                          SizedBox(height: 10),
                          CustomText(
                            text: formatDate(date: reminder.reminderDate,
                            repeat: reminder.repeat),
                            size: 19
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onPressed: (){
                                    Get.back();
                                    Get.to(() => NewReminderScreen(reminder: reminder), transition: Transition.cupertino);
                                  },
                                  text: 'edit'.tr,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomButton(
                                  onPressed: () async {
                                    Get.back();
                                    await delReminder(key: reminder.key);
                                  },
                                  text: 'delete'.tr,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  buttonColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  isScrollControlled: true
              );
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
