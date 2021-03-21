import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:simple_dri3ble/interfaces/repositories/shots_respository_interface.dart';
import 'package:simple_dri3ble/interfaces/services/connection_checker_service_interface.dart';
import 'package:simple_dri3ble/interfaces/services/local_storage_service_interface.dart';
import 'package:simple_dri3ble/models/shot_model.dart';

class ShotsViewModel {
  final String shotsStorageKey;
  final IShotsRepository shotsRepository;
  final ILocalStorageService localStorageService;
  final IConnectionCheckerService connectionCheckerService;

  final ValueNotifier<List<ShotModel>> shots =
      ValueNotifier<List<ShotModel>>(null);

  ShotsViewModel(
    this.shotsStorageKey,
    this.shotsRepository,
    this.localStorageService,
    this.connectionCheckerService,
  );

  Future<void> getShots(String accessToken) async {
    bool hasInternet = await connectionCheckerService.isConnectionAvailable();
    if (hasInternet) {
      List<ShotModel> shots = await shotsRepository.getShots(accessToken) ?? [];
      await localStorageService.put(shotsStorageKey, json.encode(shots));
      this.shots.value = shots;
    } else {
      String storedData = await localStorageService.get(shotsStorageKey);
      if (storedData.isNotEmpty) {
        List shotsMaps = json.decode(storedData);
        List<ShotModel> shots =
            shotsMaps.map((e) => ShotModel.fromJson(e)).toList();
        this.shots.value = shots;
      } else {
        this.shots.value = [];
      }
    }
  }
}
