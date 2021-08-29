import 'package:hive/hive.dart';
import 'package:remind_me_of/database/models/category/category.dart';

Future<void> createCategory({required Category category}) async {
  var box = await Hive.openBox<Category>('category');

  await box.add(category);
}

Future<List<Category>> getCategoryList() async {
  var box = await Hive.openBox<Category>('category');
  List<Category> categoryList = [];

  box.toMap().forEach((key, value) {
    categoryList.add(value);
  });

  return categoryList;
}

Future<void> updateCategory({required Category category, required int index}) async {
  var box = await Hive.openBox<Category>('category');

  await box.putAt(index, category);
}

Future<void> deleteCategory({required int index}) async {
  var box = await Hive.openBox<Category>('category');

  await box.deleteAt(index);
}