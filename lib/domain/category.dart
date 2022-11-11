import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String icon;
  @HiveField(2)
  bool chosen;

  Category({
    required this.name,
    required this.icon,
    this.chosen = true,
  });
}
