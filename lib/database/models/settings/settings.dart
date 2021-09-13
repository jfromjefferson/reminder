import 'package:hive/hive.dart';
part 'settings.g.dart';

@HiveType(typeId: 3)
class Settings extends HiveObject {
  @HiveField(0)
  String languageCode;

  @HiveField(1)
  bool deletePastReminders;

  @HiveField(2)
  bool showAds;

  Settings({required this.languageCode, required this.deletePastReminders, required this.showAds});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'languageCode': languageCode,
      'deletePastReminders': deletePastReminders,
      'showAds': showAds,
    };

    return map;
  }

}