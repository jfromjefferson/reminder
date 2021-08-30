import 'package:intl/intl.dart';
import 'package:get/get.dart';

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