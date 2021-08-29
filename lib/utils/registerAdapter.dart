import 'package:hive/hive.dart';
import 'package:remind_me_of/database/models/category/category.dart';
import 'package:remind_me_of/database/models/reminder/reminder.dart';

void registerAdapter(){
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ReminderAdapter());
}