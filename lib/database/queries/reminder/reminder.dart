import 'package:hive/hive.dart';
import 'package:remind_me_of/database/models/reminder/reminder.dart';
import 'package:remind_me_of/services/local_notification.dart';

Future<void> createReminder({required Reminder reminder}) async {
  var box = await Hive.openBox<Reminder>('reminder');

  await box.add(reminder);
}

Future<List<Reminder>> getReminderList({String ?category}) async {
  var box = await Hive.openBox<Reminder>('reminder');
  List<Reminder> reminderList = [];
  DateTime now = DateTime.now();

  if(category != ''){
    var list = box.values.where((reminder) => reminder.category == category);

    list.forEach((value) async {
      if(value.reminderDate.isBefore(now)){
        if(value.repeat == '' || value.repeat == 'not_repeat'){
          await LocalNotificationService.cancelNotification(id: value.key);
          await deleteReminder(key: value.key);
        }
      }else{
        reminderList.add(value);
      }
    });

  }else{
    box.toMap().forEach((key, value) async {
      if(value.reminderDate.isBefore(now)){
        if(value.repeat == '' || value.repeat == 'not_repeat'){
          await LocalNotificationService.cancelNotification(id: value.key);
          await deleteReminder(key: value.key);
        }
      }else{
        reminderList.add(value);
      }
    });
  }

  return reminderList;
}

Future<void> deleteReminder({required int key}) async {
  var box = await Hive.openBox<Reminder>('reminder');

  await box.delete(key);
}

Future<void> updateReminder({required Reminder reminder, required int key}) async {
  var box = await Hive.openBox<Reminder>('reminder');

  await box.put(key, reminder);

}