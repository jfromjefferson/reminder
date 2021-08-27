import 'package:hive/hive.dart';
import 'package:remind_me_of/database/models/category/category.dart';

part 'reminder.g.dart';

@HiveType(typeId: 1)
class Reminder extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late DateTime reminderDate;

  @HiveField(3)
  late bool repeat;

  @HiveField(4)
  late Category ?category;

  Reminder({
    this.category,
    required this.content,
    required this.reminderDate,
    required this.repeat,
    required this.title
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': title,
      'content': content,
      'reminderDate': reminderDate,
      'repeat': repeat,
      'category': category,
    };

    return map;
  }

  Reminder.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    content = map['content'];
    reminderDate = map['reminderDate'];
    repeat = map['repeat'];
    category = map['category'];
  }

}
