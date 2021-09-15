import 'package:hive/hive.dart';
part 'settings.g.dart';

@HiveType(typeId: 3)
class Settings extends HiveObject {
  @HiveField(0)
  String languageCode;

  @HiveField(1)
  bool deletePastReminders;

  @HiveField(2)
  bool removeAds;

  Settings({required this.languageCode, required this.deletePastReminders, required this.removeAds});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'languageCode': languageCode,
      'deletePastReminders': deletePastReminders,
      'removeAds': removeAds,
    };

    return map;
  }

}