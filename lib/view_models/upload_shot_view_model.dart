import 'dart:async';
import 'dart:convert';

import 'package:simple_dri3ble/interfaces/repositories/shots_respository_interface.dart';
import 'package:simple_dri3ble/interfaces/services/connection_checker_service_interface.dart';
import 'package:simple_dri3ble/interfaces/services/local_storage_service_interface.dart';
import 'package:simple_dri3ble/models/shot_model.dart';

class UploadShotViewModel {
  final String accessToken;
  final String offlineShotsStorageKey;
  final IShotsRepository shotsRepository;
  final ILocalStorageService localStorageService;
  final IConnectionCheckerService connectionCheckerService;

  final StreamController<bool> _isUploading =
      StreamController<bool>.broadcast();

  final StreamController<ShotModel> _isUploaded = StreamController<ShotModel>();

  UploadShotViewModel(
      this.accessToken,
      this.offlineShotsStorageKey,
      this.shotsRepository,
      this.localStorageService,
      this.connectionCheckerService);

  Sink<bool> get isUploadingInput => _isUploading.sink;
  Stream<bool> get isUploadingOutput => _isUploading.stream;

  Sink<ShotModel> get isUploadedInput => _isUploaded.sink;
  Stream<bool> get isUploadedOutput => _isUploaded.stream.asyncMap(uploadShot);

  Future<bool> uploadShot(ShotModel shotModel) async {
    bool created;
    bool hasInernet = await connectionCheckerService.isConnectionAvailable();
    if (hasInernet) {
      _isUploading.add(true);
      try {
        created = await shotsRepository.postShot(shotModel, accessToken);
      } catch (e) {
        created = false;
      }
      _isUploading.add(false);
    } else {
      isUploadingInput.add(true);
      String data = await localStorageService.get(offlineShotsStorageKey);
      if (data.isEmpty) {
        created = await localStorageService.put(
            offlineShotsStorageKey, json.encode([shotModel]));
      } else {
        List shotsMaps = json.decode(data);
        shotsMaps.add(shotModel.toJson());
        created = await localStorageService.put(
            offlineShotsStorageKey, json.encode(shotsMaps));
      }
      isUploadingInput.add(false);
    }
    return created;
  }

  Future<void> uploadOfflineShots() async {
    isUploadingInput.add(true);
    await Future.delayed(Duration(seconds: 2));
    bool hasInternet = await connectionCheckerService.isConnectionAvailable();
    if (hasInternet) {
      String data = await localStorageService.get(offlineShotsStorageKey);
      if (data.isNotEmpty) {
        List shotsMaps = json.decode(data);
        List<ShotModel> shots =
            shotsMaps.map((e) => ShotModel.fromJson(e)).toList();
        for (int index = 0; index < shots.length; index++) {
          try {
            bool uploaded =
                await shotsRepository.postShot(shots[index], accessToken);
            if (uploaded) shotsMaps.removeAt(index);
          } catch (e) {
            print(e);
          }
        }
        if (shotsMaps.isEmpty) {
          await localStorageService.delete(offlineShotsStorageKey);
        } else {
          await localStorageService.put(
              offlineShotsStorageKey, json.encode(shotsMaps));
        }
      }
    }
    isUploadingInput.add(false);
  }

  void dispose() {
    _isUploading.close();
    _isUploaded.close();
  }
}
