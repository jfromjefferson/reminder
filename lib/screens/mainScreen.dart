import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/controllers/appController.dart';
import 'package:remind_me_of/widgets/customText.dart';

class MainScreen extends StatelessWidget {
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(text: 'title'.tr, size: 30, weight: FontWeight.bold),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: FutureBuilder(
                    future: appController.createReminderList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.hasData){
                        return ListView(
                          children: [
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.spaceBetween,
                              children: snapshot.data,
                            )
                          ],
                        );
                      }else{
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
