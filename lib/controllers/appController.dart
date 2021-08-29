import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/database/models/category/category.dart';
import 'package:remind_me_of/database/models/reminder/reminder.dart';
import 'package:remind_me_of/database/queries/category/category.dart';
import 'package:remind_me_of/database/queries/reminder/reminder.dart';

class AppController extends GetxController {
  var repeatReminder = false.obs;
  var categoryList = [].obs;
  var categoryNameToEdit = ''.obs;

  @override
  void onInit() async {
    categoryList.value = await getCategoryList();

    super.onInit();
  }

  Future<void> newReminder({required Reminder reminder}) async {
    await createReminder(reminder: reminder);
  }

  void setRepeatReminder({required bool value}) {
    repeatReminder.value = value;
  }

  Future<void> categoryConfig({required String categoryName}) async {
    if (categoryName.isNotEmpty) {
      Category category = Category(name: categoryName);

      await createCategory(category: category);
      categoryList.value = await getCategoryList();
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
    update();
  }

  Future<void> updCategory({required String categoryName, required int index}) async {
    if(categoryName.isNotEmpty){
      Category category = Category(name: categoryName);
      await updateCategory(category: category, index: index);
      categoryList.value = await getCategoryList();
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

}
