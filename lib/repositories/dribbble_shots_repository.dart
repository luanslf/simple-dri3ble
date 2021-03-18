import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:simple_dri3ble/interfaces/repositories/shots_respository_interface.dart';
import 'package:simple_dri3ble/interfaces/services/http_client_service_interface.dart';
import 'package:simple_dri3ble/models/request_login_model.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/models/login_model.dart';

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

  @override
  Future<bool> createShot(ShotModel shotModel, String accessToken) async {
    bool created;
    String url = 'https://api.dribbble.com/v2/shots';
    Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};
    File file = File(shotModel.images.first);
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      'title': shotModel.title,
      'description': shotModel.description,
      'image': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType('image', 'jpeg'),
      ),
    });
    try {
      final responseData = await httpClient.post(url, data, headers: headers);
      print('responseData: $responseData');
      created = true;
    } catch (e) {
      print(e);
      created = false;
    }
    return created;
  }

  @override
  Future<LoginModel> getAccessToken(RequestLoginModel requestLoginModel) async {
    LoginModel loginModel;
    String url = 'https://dribbble.com/oauth/token';
    Map<String, dynamic> data = {
      'client_id': requestLoginModel.clientId,
      'client_secret': requestLoginModel.clientSecret,
      'code': requestLoginModel.code
    };
    try {
      Map<String, dynamic> response = await httpClient.post(url, data);
      loginModel = LoginModel.fromJson(response);
    } catch (e) {
      print(e);
    }
    return loginModel;
  }
}
