class ShotModel {
  int _id;
  String _title;
  String _description;
  String _publishedAt;
  List<String> _images;

  ShotModel() {
    _images = List<String>();
  }

  ShotModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _publishedAt = json['published_at'];
    Map<String, dynamic> imagesMap = json['images'];
    _images = List.from(imagesMap.values.where((e) => e != null));
  }

  int get id => _id;
  String get title => _title;
  set title(String title) => _title = title;
  String get description => _description;
  set description(String description) => _description = description;
  String get publishedAt => _publishedAt;
  List<String> get images => _images;
}
