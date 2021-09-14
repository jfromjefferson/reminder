import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_of/database/models/settings/settings.dart';
import 'package:remind_me_of/services/ads_service.dart';

class FutureAds extends StatelessWidget {
  final AdmobBannerSize size;
  final Settings settings;

  FutureAds({required this.size, required this.settings});

  Future<bool> loading() async {
    await Future.delayed(Duration(seconds: 1));

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loading(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData && !settings.showAds){
          //return Text('Isso é um anuncio');
          return AdmobBanner(
            adSize: size,
            adUnitId: AdsService().getBannerId(),
          );
        }else{
          return SizedBox();
        }
      },
    );
  }
}
