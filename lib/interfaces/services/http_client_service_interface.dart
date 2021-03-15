abstract class IHttpClientService {
  Future get(String url, {Map<String, String> headers});
  Future post(String url, dynamic data, {Map<String, String> headers});
}
