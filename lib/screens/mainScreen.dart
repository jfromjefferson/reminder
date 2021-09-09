import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remind_me_of/controllers/appController.dart';
import 'package:remind_me_of/utils/colors.dart';
import 'package:remind_me_of/widgets/customButton.dart';
import 'package:remind_me_of/widgets/customText.dart';
import 'package:select_form_field/select_form_field.dart';

class MainScreen extends StatelessWidget {
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AppController>(
          builder: (_){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(text: 'title'.tr, size: 30, weight: FontWeight.bold),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              Get.dialog(
                                GestureDetector(
                                  onTap: (){
                                    Get.focusScope!.unfocus();
                                  },
                                  child: AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: CustomText(text: 'search_title'.tr),
                                    content: Container(
                                      height: 180,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ListView.separated(
                                              itemCount: appController.categoryList.length,
                                              separatorBuilder: (BuildContext context, int index) => SizedBox(height: 5),
                                              itemBuilder: (BuildContext context, int index){
                                                return Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        appController.setCategoryFilter(
                                                            category: appController.categoryList[index].name
                                                        );
                                                      },
                                                      child: ListTile(
                                                        title: CustomText(text: appController.categoryList[index].name),
                                                      ),
                                                    ),
                                                    Divider(color: Colors.grey, height: 0)
                                                  ],
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      CustomButton(
                                        onPressed: (){
                                          appController.setCategoryFilter(category: '');
                                        },
                                        text: 'clear_search'.tr,
                                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        buttonColor: primaryColor,
                                        textSize: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(LineIcons.search, size: 35),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: (){
                              Get.dialog(
                                GestureDetector(
                                  onTap: (){
                                    Get.focusScope!.unfocus();
                                  },
                                  child: AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: CustomText(text: 'settings_title'.tr),
                                    content: Container(
                                      height: 180,
                                      child: Column(
                                        children: [
                                          SelectFormField(
                                            icon: Icon(LineIcons.language, size: 30, color: primaryColor),
                                            type: SelectFormFieldType.dropdown,
                                            initialValue: '${Get.locale}',
                                            labelText: 'change_language'.tr,
                                            items: [
                                              {'value': 'en_US', 'label': 'English'},
                                              {'value': 'pt_BR', 'label': 'Português'}
                                            ],
                                            onChanged: (value) {
                                              Locale locale = Locale(value);
                                              Get.updateLocale(locale);
                                            },
                                            onSaved: (value) => {},
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(LineIcons.cog, size: 35),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: FutureBuilder(
                        future: appController.createReminderList(),
                        builder: (BuildContext context, AsyncSnapshot snapshot){
                          if(snapshot.hasData){
                            if(snapshot.data.length > 0){
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
                              return Center(
                                child: CustomText(text: 'empty'.tr, size: 23),
                              );
                            }

                          }else{
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
