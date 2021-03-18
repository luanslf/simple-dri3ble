import 'dart:async';

import 'package:simple_dri3ble/models/login_model.dart';
import 'package:simple_dri3ble/models/request_login_model.dart';

import '../interfaces/repositories/shots_respository_interface.dart';

class LoginViewModel {
  final IShotsRepository shotsRepository;

  final _isAuthenticating = StreamController<bool>();
  final _isAuthenticaded = StreamController<RequestLoginModel>();

  LoginViewModel(this.shotsRepository);

  Sink<bool> get isAuthenticatingInput => _isAuthenticating.sink;

  Stream<bool> get isAuthenticatingOutput => _isAuthenticating.stream;

  Sink<RequestLoginModel> get isAuthenticatedInput => _isAuthenticaded.sink;

  Stream<LoginModel> get isAuthenticatedOutput =>
      _isAuthenticaded.stream.asyncMap(requestLogin);

  Future<LoginModel> requestLogin(RequestLoginModel requestLoginModel) async {
    LoginModel loginModel;
    isAuthenticatingInput.add(true);
    //await Future.delayed(Duration(seconds: 2));
    loginModel = await shotsRepository.getAccessToken(requestLoginModel);
    isAuthenticatingInput.add(false);
    return loginModel;
  }

  void dispose() {
    _isAuthenticating.close();
    _isAuthenticaded.close();
  }
}
