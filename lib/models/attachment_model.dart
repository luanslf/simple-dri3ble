class AttachmentModel {
  int _id;
  String _url;
  String _thumbnailUrl;
  int _size;
  String _contentType;
  String _createdAt;

  AttachmentModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _url = json['url'];
    _thumbnailUrl = json['thumbnail_url'];
    _size = json['size'];
    _contentType = json['content_type'];
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['url'] = this._url;
    data['thumbnail_url'] = this._thumbnailUrl;
    data['size'] = this._size;
    data['content_type'] = this._contentType;
    data['created_at'] = this._createdAt;
    return data;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get url => _url;
  set url(String url) => _url = url;
  String get thumbnailUrl => _thumbnailUrl;
  set thumbnailUrl(String thumbnailUrl) => _thumbnailUrl = thumbnailUrl;
  int get size => _size;
  set size(int size) => _size = size;
  String get contentType => _contentType;
  set contentType(String contentType) => _contentType = contentType;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
}
