import 'package:simple_dri3ble/interfaces/repositories/shots_respository_interface.dart';
import 'package:simple_dri3ble/interfaces/services/http_client_service_interface.dart';
import 'package:simple_dri3ble/models/shot_model.dart';

class DribbbleShotsRepository implements IShotsRepository {
  final IHttpClientService httpClient;

  DribbbleShotsRepository(this.httpClient);

  @override
  Future<List<ShotModel>> getShots(String accessToken) async {
    List<ShotModel> shots;
    String url = 'https://api.dribbble.com/v2/user/shots';
    Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};
    try {
      List data = await httpClient.get(url, headers: headers);
      shots = data.map((e) => ShotModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
    return shots;
  }
}
