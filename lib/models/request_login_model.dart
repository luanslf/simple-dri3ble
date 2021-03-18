class RequestLoginModel {
  final String clientId;
  final String clientSecret;
  final String code;

  RequestLoginModel(this.clientId, this.clientSecret, this.code);

  Map<String, String> toJson() {
    Map<String, String> data = Map<String, String>();
    data['client_id'] = clientId;
    data['client_secret'] = clientSecret;
    data['code'] = code;
    return data;
  }
}
