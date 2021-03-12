class ImagesModel {
  String _hidpi;
  String _normal;
  String _teaser;

  ImagesModel.fromJson(Map<String, dynamic> json) {
    _hidpi = json['hidpi'];
    _normal = json['normal'];
    _teaser = json['teaser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hidpi'] = this._hidpi;
    data['normal'] = this._normal;
    data['teaser'] = this._teaser;
    return data;
  }

  String get hidpi => _hidpi;
  set hidpi(String hidpi) => _hidpi = hidpi;
  String get normal => _normal;
  set normal(String normal) => _normal = normal;
  String get teaser => _teaser;
  set teaser(String teaser) => _teaser = teaser;
}
