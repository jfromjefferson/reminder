import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remind_me_of/database/models/reminder/reminder.dart';

import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static final NotificationDetails _notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          'easymessage',
          'easymessage_channel',
          'Custom channel',
          importance: Importance.max,
          priority: Priority.high
      )
  );

  static Future<void> initialize() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher')
    );

    _notificationsPlugin.initialize(initializationSettings);
    //_notificationsPlugin.cancelAll();
  }

  static Future<void> schedule({required Reminder reminder}) async {

    try {
      tz.TZDateTime time = tz.TZDateTime.from(reminder.reminderDate, tz.local);

      DateTimeComponents ?repeat;

      if(reminder.repeat == 'once_a_day'){
        repeat = DateTimeComponents.time;
      }else if(reminder.repeat == 'once_a_week'){
        repeat = DateTimeComponents.dayOfWeekAndTime;
      }

      await _notificationsPlugin.zonedSchedule(
        reminder.key,
        reminder.title,
        reminder.content,
        time,
        _notificationDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: repeat,
      );
    }catch (e) {
      print(e);
    }

  }

  static Future<void> cancelNotification({required int id}) async {
    await _notificationsPlugin.cancel(id);
  }

}