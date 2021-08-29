import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:remind_me_of/controllers/appController.dart';
import 'package:remind_me_of/utils/colors.dart';
import 'package:remind_me_of/widgets/customButton.dart';
import 'package:remind_me_of/widgets/customText.dart';
import 'package:get/get.dart';
import 'package:remind_me_of/widgets/customTextField.dart';

class CategoryListScreen extends StatelessWidget {
  final AppController appController = Get.find();
  final TextEditingController categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'categories'.tr),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GetBuilder<AppController>(
              builder: (value){
                return Expanded(
                  child: ListView.separated(
                    itemCount: appController.categoryList.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey),
                    itemBuilder: (BuildContext context, int index){
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction){
                          appController.delCategory(index: index);
                        },
                        background: Container(color: Colors.redAccent, padding: EdgeInsets.all(10),),
                        child: GestureDetector(
                          onTap: (){
                            appController.categoryNameToEdit.value = appController.categoryList[index].name;
                            categoryNameController..text = appController.categoryList[index].name;
                            Get.bottomSheet(
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                      color: Colors.white
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        CustomText(text: 'category_update'.tr, align: TextAlign.center, size: 22),
                                        SizedBox(height: 20),
                                        CustomTextField(
                                          controller: categoryNameController,
                                          onChanged: (String value){
                                            value = value.trim();

                                            appController.categoryNameToEdit.value = value;
                                          },
                                          hintText: 'category'.tr,
                                          textColor: Colors.black,
                                          autoFocus: true,
                                        ),
                                        SizedBox(height: 30),
                                        CustomButton(
                                          onPressed: (){
                                            appController.updCategory(
                                              categoryName: appController.categoryNameToEdit.value,
                                              index: index
                                            );
                                            appController.categoryNameToEdit.value = '';
                                            categoryNameController.clear();
                                          },
                                          text: 'update'.tr,
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          buttonColor: primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                isScrollControlled: true
                            );
                          },
                          child: ListTile(
                            title: CustomText(text: appController.categoryList[index].name, size: 18),
                            trailing: Icon(LineIcons.edit, size: 30, color: primaryColor),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.bottomSheet(
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                ),
                color: Colors.white
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomText(text: 'new_category'.tr, align: TextAlign.center, size: 22),
                    SizedBox(height: 20),
                    CustomTextField(
                      onChanged: (String value){
                        value = value.trim();

                        categoryNameController..text = value;
                      },
                      hintText: 'category'.tr,
                      textColor: Colors.black,
                      autoFocus: true,
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      onPressed: (){
                        appController.categoryConfig(categoryName: categoryNameController.text);
                        categoryNameController.clear();
                      },
                      text: 'create'.tr,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      buttonColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            isScrollControlled: true
          );
        },
        child: Icon(LineIcons.plus),
        backgroundColor: primaryColor,
      ),
    );
  }
}
