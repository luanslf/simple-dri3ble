import 'package:simple_dri3ble/models/request_login_model.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/models/login_model.dart';

abstract class IShotsRepository {
  Future<List<ShotModel>> getShots(String accessToken);
  Future<bool> postShot(ShotModel shotModel, String accessToken);
  Future<LoginModel> getAccessToken(RequestLoginModel requestLoginModel);
}
