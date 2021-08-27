import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
class Category extends HiveObject {
  @HiveField(0)
  late String name;

  Category({required this.name});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
    };

    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    name = map['name'];
  }

}