class Sight {
  String name;
  double lat;
  double lon;
  List<String> url;
  String details;
  String type;
  bool liked;

  Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
    this.liked = false,
  });
}
