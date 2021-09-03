import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remind_me_of/database/models/reminder/reminder.dart';

import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static final NotificationDetails _notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          'easymessage',
          'easymessage_channel',
          'Custom channel',
          importance: Importance.max,
          priority: Priority.high
      )
  );

  static void initialize(){
    final InitializationSettings initializationSettings = InitializationSettings(android: AndroidInitializationSettings('ic_launcher'));

    _notificationsPlugin.initialize(initializationSettings);
  }

  static void single({required Reminder reminder}) async {
    try {

      await _notificationsPlugin.show(
        reminder.key,
        reminder.title,
        reminder.content,
        _notificationDetails
      );
    } on Exception catch (e) {
      print(e);
    }

  }

  static void schedule({required Reminder reminder}) async {

    try {
      tz.TZDateTime time = tz.TZDateTime.from(reminder.reminderDate, tz.local);

      await _notificationsPlugin.zonedSchedule(
        reminder.key,
        reminder.title,
        reminder.content,
        time,
        _notificationDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true
      );
    } on Exception catch (e) {
      print(e);
    }

  }

  static void periodically({required Reminder reminder}) async {

    try {
      RepeatInterval repeat = RepeatInterval.daily;

      if(reminder.repeat == 'once_a_week'){
        repeat = RepeatInterval.weekly;
      }

      await _notificationsPlugin.periodicallyShow(
          reminder.key,
          reminder.title,
          reminder.content,
          repeat,
          _notificationDetails,
          androidAllowWhileIdle: true
      );
    } on Exception catch (e) {
      print(e);
    }

  }

}