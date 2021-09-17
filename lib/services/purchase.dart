import 'package:purchases_flutter/offering_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:remind_me_of/services/keys.dart';

class PurchaseApi {
  static final String _apiKey = Keys.reminderKey;

  static Future init() async {
    await Purchases.setDebugLogsEnabled(false);
    await Purchases.setup(_apiKey);
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;

      return current == null ? [] : [current];
    } on Exception catch (_) {
      return [];
    }
  }

  static Future<bool> purchasePackage({required Package package}) async{
    try {
      PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
      if(purchaserInfo.entitlements.active.isEmpty){
        await Purchases.purchasePackage(package);
        return true;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

}