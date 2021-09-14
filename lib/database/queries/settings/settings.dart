import 'package:hive/hive.dart';
import 'package:remind_me_of/database/models/settings/settings.dart';

Future<Settings> getSettings() async {
  var box = await Hive.openBox<Settings>('settingsBox');

  Settings settings = Settings(languageCode: 'en_US', deletePastReminders: true, showAds: true);

  if(box.length == 0){
    await box.add(settings);
  }else{
    settings = box.get(0)!;
  }

  return settings;
}

Future<void> updateSettings({required Settings settings}) async {
  var box = await Hive.openBox<Settings>('settingsBox');

  await box.put(0, settings);
}