import 'package:simple_dri3ble/utils/constants.dart';

class AuthorizerViewModel {
  String authorizerUrl() =>
      Constants.authorizeUrl +
      Constants.client_id +
      Constants.authorizeUrlScopeParameters;
}
