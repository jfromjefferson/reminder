import 'package:device_info/device_info.dart';
import 'package:hive/hive.dart';
import 'package:remind_me_of/database/models/settings/settings.dart';
import 'package:remind_me_of/utils/functions.dart';

Future<Settings> getSettings() async {
  var box = await Hive.openBox<Settings>('settingsBox');
  AndroidDeviceInfo deviceInfo = await getDeviceInfo();

  String ownerId = '407bb24bd7332841';
  bool showAds = true;

  if(deviceInfo.androidId == ownerId){
    showAds = false;
  }

  Settings settings = Settings(languageCode: 'en_US', deletePastReminders: true, showAds: showAds);

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