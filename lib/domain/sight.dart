import 'package:hive/hive.dart';
import 'package:places/presets/strings/app_strings.dart';

part 'sight.g.dart';

@HiveType(typeId: 0)
class Sight extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  double lat;
  @HiveField(2)
  double lon;
  @HiveField(3)
  List<String> url;
  @HiveField(4)
  String details;
  @HiveField(5)
  String type;
  @HiveField(6)
  bool liked;
  @HiveField(7)
  bool visited;
  @HiveField(8)
  String workingHours;
  @HiveField(9)
  String timeVisit;
  @HiveField(10)
  List<String> addedImages;

  Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
    this.liked = false,
    this.visited = false,
    this.workingHours = AppStrings.scrTimeDetailScreen,
    this.timeVisit = '',
    this.addedImages = const [],
  });
}
