import 'dart:async';

import 'package:simple_dri3ble/interfaces/repositories/shots_respository_interface.dart';
import 'package:simple_dri3ble/models/shot_model.dart';

class UploadShotViewModel {
  final IShotsRepository shotsRepository;

  final StreamController<bool> _isUploading =
      StreamController<bool>.broadcast();

  final StreamController<ShotModel> _isUploaded = StreamController<ShotModel>();

  UploadShotViewModel(this.shotsRepository);

  Sink<bool> get isUploadingInput => _isUploading.sink;
  Stream<bool> get isUploadingOutput => _isUploading.stream;

  Sink<ShotModel> get isUploadedInput => _isUploaded.sink;
  Stream<bool> get isUploadedOutput => _isUploaded.stream.asyncMap(createShot);

  Future<bool> createShot(ShotModel shotModel) async {
    bool created;
    _isUploading.add(true);
    try {
      created = await shotsRepository.createShot(shotModel,
          '98d6f81088bafa64b6daa413165b81a8756874664284692f4ad12bf5cb15a24b');
    } catch (e) {
      created = false;
    }
    _isUploading.add(false);
    return created;
  }

  void dispose() {
    _isUploading.close();
    _isUploaded.close();
  }
}
