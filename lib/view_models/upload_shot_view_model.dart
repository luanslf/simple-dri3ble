import 'dart:async';

class UploadShotViewModel {
  final StreamController<bool> _isUploading =
      StreamController<bool>.broadcast();

  Sink<bool> get isUploadingInput => _isUploading.sink;
  Stream<bool> get isUploadingOutput => _isUploading.stream;

  Future<bool> upload(bool value) async {
    _isUploading.add(true);
    await Future.delayed(Duration(seconds: 3));
    _isUploading.add(false);
    return value;
  }

  void dispose() {
    _isUploading.close();
  }
}
