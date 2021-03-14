import 'package:flutter/foundation.dart';
import 'package:simple_dri3ble/interfaces/repositories/shots_respository_interface.dart';
import 'package:simple_dri3ble/models/shot_model.dart';

class ShotsViewModel {
  final IShotsRepository shotsRepository;

  final ValueNotifier<List<ShotModel>> shots =
      ValueNotifier<List<ShotModel>>(null);

  ShotsViewModel(this.shotsRepository);

  Future<void> getShots() async {
    String accessToken =
        '25fb8f2ebb0105adf4cd57a681b348e095c580bff1cb7d478648351568fb5e9d';
    shots.value = await shotsRepository.getShots(accessToken) ?? [];
  }
}
