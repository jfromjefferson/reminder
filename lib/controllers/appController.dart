import 'package:get/get.dart';
import 'package:remind_me_of/database/models/reminder/reminder.dart';
import 'package:remind_me_of/database/queries/reminder/reminder.dart';

class AppController extends GetxController {
  var repeatReminder = false.obs;

  Future<void> newReminder({required Reminder reminder}) async {
    await createReminder(reminder: reminder);
  }

  void setRepeatReminder({required bool value}){
    repeatReminder.value = value;
  }

}