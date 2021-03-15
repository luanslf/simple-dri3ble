import 'package:simple_dri3ble/models/attachment_model.dart';
import 'package:simple_dri3ble/models/images_model.dart';

class ShotModel {
  int _id;
  String _title;
  String _description;
  ImagesModel _images;
  String _publishedAt;
  String _updatedAt;
  List<String> _tags;
  List<AttachmentModel> _attachments;
  bool _lowProfile;

  ShotModel();

  ShotModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _images = json['images'] != null
        ? new ImagesModel.fromJson(json['images'])
        : null;
    _publishedAt = json['published_at'];
    _updatedAt = json['updated_at'];
    _tags = json['tags'].cast<String>();
    if (json['attachments'] != null) {
      _attachments = new List<AttachmentModel>();
      json['attachments'].forEach((v) {
        _attachments.add(new AttachmentModel.fromJson(v));
      });
    }
    _lowProfile = json['low_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['description'] = this._description;
    if (this._images != null) {
      data['images'] = this._images.toJson();
    }
    data['published_at'] = this._publishedAt;
    data['updated_at'] = this._updatedAt;
    data['tags'] = this._tags;
    if (this._attachments != null) {
      data['attachments'] = this._attachments.map((v) => v.toJson()).toList();
    }
    data['low_profile'] = this._lowProfile;
    return data;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  String get description => _description;
  set description(String description) => _description = description;
  ImagesModel get images => _images;
  set images(ImagesModel images) => _images = images;
  String get publishedAt => _publishedAt;
  set publishedAt(String publishedAt) => _publishedAt = publishedAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  List<String> get tags => _tags;
  set tags(List<String> tags) => _tags = tags;
  List<AttachmentModel> get attachments => _attachments;
  set attachments(List<AttachmentModel> attachments) =>
      _attachments = attachments;
  bool get lowProfile => _lowProfile;
  set lowProfile(bool lowProfile) => _lowProfile = lowProfile;
}
