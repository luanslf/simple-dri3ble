abstract class IHttpClientService {
  Future get(String url, {Map<String, String> headers});
}
