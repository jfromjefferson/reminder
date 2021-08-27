import 'package:hive/hive.dart';
import 'package:remind_me_of/database/models/reminder/reminder.dart';

Future<void> createReminder({required Reminder reminder}) async {
  var box = await Hive.openBox<Reminder>('reminder');

  await box.add(reminder);
}

Future<List<Reminder>> getReminderList() async {
  var box = await Hive.openBox<Reminder>('reminder');
  List<Reminder> reminderList = [];

  box.toMap().forEach((key, value) {
    reminderList.add(value);
  });

  return reminderList;
}