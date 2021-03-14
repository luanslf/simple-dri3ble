import 'package:dio/dio.dart';
import 'package:simple_dri3ble/interfaces/services/http_client_service_interface.dart';

class DioHttpClientService implements IHttpClientService {
  @override
  Future<dynamic> get(String url, {Map<String, String> headers}) async {
    Response response =
        await Dio().get(url, options: Options(headers: headers));
    return response.data;
  }
}
