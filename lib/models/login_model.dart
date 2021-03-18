class LoginModel {
  String _accessToken;
  String _tokenType;
  String _scope;

  LoginModel.fromJson(Map<String, dynamic> json) {
    _accessToken = json['access_token'];
    _tokenType = json['token_type'];
    _scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this._accessToken;
    data['token_type'] = this._tokenType;
    data['scope'] = this._scope;
    return data;
  }

  String get accessToken => _accessToken;
  set accessToken(String accessToken) => _accessToken = accessToken;
  String get tokenType => _tokenType;
  set tokenType(String tokenType) => _tokenType = tokenType;
  String get scope => _scope;
  set scope(String scope) => _scope = scope;
}
