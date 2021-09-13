import 'package:hive/hive.dart';

part 'reminder.g.dart';

@HiveType(typeId: 1)
class Reminder extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String ?content;

  @HiveField(2)
  late DateTime reminderDate;

  @HiveField(3)
  late String ?repeat;

  @HiveField(4)
  late String ?category;

  @HiveField(5)
  late int color;

  Reminder({
    this.category,
    this.content,
    required this.reminderDate,
    this.repeat,
    required this.title,
    required this.color
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': title,
      'content': content,
      'reminderDate': reminderDate,
      'repeat': repeat,
      'category': category,
      'color': color,
    };

    return map;
  }

  Reminder.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    content = map['content'];
    reminderDate = map['reminderDate'];
    repeat = map['repeat'];
    category = map['category'];
    color = map['color'];
  }

}
