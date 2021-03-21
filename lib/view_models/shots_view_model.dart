import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:simple_dri3ble/interfaces/repositories/shots_respository_interface.dart';
import 'package:simple_dri3ble/interfaces/services/local_storage_service_interface.dart';
import 'package:simple_dri3ble/models/shot_model.dart';

class ShotsViewModel {
  final String shotsStoreKey;
  final IShotsRepository shotsRepository;
  final ILocalStorageService localStorageService;

  final ValueNotifier<List<ShotModel>> shots =
      ValueNotifier<List<ShotModel>>(null);

  ShotsViewModel(
      this.shotsStoreKey, this.shotsRepository, this.localStorageService);

  Future<void> getShots(String accessToken) async {
    List<ShotModel> shots = await shotsRepository.getShots(accessToken) ?? [];
    await localStorageService.put(shotsStoreKey, json.encode(shots));
    this.shots.value = shots;
  }
}
