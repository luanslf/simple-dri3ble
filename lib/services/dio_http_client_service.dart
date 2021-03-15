import 'package:dio/dio.dart';
import 'package:simple_dri3ble/interfaces/services/http_client_service_interface.dart';

class DioHttpClientService implements IHttpClientService {
  @override
  Future<dynamic> get(String url, {Map<String, String> headers}) async {
    Response response =
        await Dio().get(url, options: Options(headers: headers));
    return response.data;
  }

  @override
  Future<dynamic> post(String url, dynamic data,
      {Map<String, String> headers}) async {
    Response response = await Dio().post(
      url,
      data: data,
      options: Options(
        headers: headers,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return response.data;
  }
}
