import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_dri3ble/interfaces/repositories/shots_respository_interface.dart';
import 'package:simple_dri3ble/models/login_model.dart';
import 'package:simple_dri3ble/models/request_login_model.dart';
import 'package:simple_dri3ble/view_models/login_view_model.dart';

class ShotsRepositoryMock extends Mock implements IShotsRepository {}

main() {
  final shotsRepository = ShotsRepositoryMock();

  final loginViewModel = LoginViewModel(shotsRepository);

  group("Login ViewModel Test", () {
    test("null request login model means a null login model", () async {
      when(shotsRepository.getAccessToken(null)).thenAnswer((_) => null);
      final loginModel = await loginViewModel.requestLogin(null);
      expect(loginModel, isNull);
    });
    test("request login model with success", () async {
      final requestLoginModel = RequestLoginModel("123", "456", "789");
      Future future = Future<LoginModel>.value(LoginModel.fromJson({
        'access_token':
            '98d6f81088bafa64b6daa413165b81a8756874664284692f4ad12bf5cb15a24b',
        'token_type': 'bearer',
        'scope': 'public upload'
      }));
      when(shotsRepository.getAccessToken(requestLoginModel))
          .thenAnswer((_) => future);
      final loginModel = await loginViewModel.requestLogin(requestLoginModel);
      expect(loginModel, isA<LoginModel>());
    });
  });
}
