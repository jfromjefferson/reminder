import 'package:purchases_flutter/offering_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static final String _apiKey = '';

  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);
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
}