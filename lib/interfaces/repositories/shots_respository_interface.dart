import 'package:simple_dri3ble/models/shot_model.dart';

abstract class IShotsRepository {
  Future<List<ShotModel>> getShots(String accessToken);
}
