import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/utils/colors.dart';

String formatDate({required DateTime date, String ?repeat}){
  DateTime today = DateTime.now();
  String hourFormatted = DateFormat('HH:mm').format(date);
  String dateFormatted = DateFormat('date_format_dm'.tr).format(date);

  if(today.day == date.day && today.month == date.month){
    return '${"today".tr}, $hourFormatted';
  }else if(repeat == 'once_a_day'){
    return '${"everyday".tr}, $hourFormatted';
  }else if(repeat == 'once_a_week'){
    return '${"every_week".tr}, $hourFormatted';
  }else if(repeat == 'once_a_month'){
    return '${"every_month".tr}, $hourFormatted';
  }else{
  return dateFormatted;
  }

}

void alert({required String title, required String message}){
  bool hasError = false;
  if(title.contains('error')){
    hasError = true;
  }

  Get.snackbar(
      '$title'.tr,
      '$message'.tr,
      backgroundColor: hasError ? Color(0xfff94144): Color(0xff2d6a4f),
      colorText: Colors.white,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5)
  );
}