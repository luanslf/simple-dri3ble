import 'package:dio/dio.dart';
import 'package:simple_dri3ble/interfaces/services/http_client_service_interface.dart';

class DioHttpClientService implements IHttpClientService {
  Dio dio = Dio();

  @override
  Future<dynamic> get(String url, {Map<String, String> headers}) async {
    Response response = await dio.get(url, options: Options(headers: headers));
    return response.data;
  }

  @override
  Future<dynamic> post(String url, dynamic data,
      {Map<String, String> headers}) async {
    Response response = await dio.post(
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
