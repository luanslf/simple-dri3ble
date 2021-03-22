import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_dri3ble/interfaces/services/local_storage_service_interface.dart';
import 'package:simple_dri3ble/models/login_model.dart';
import 'package:simple_dri3ble/stores/app_store.dart';
import 'package:simple_dri3ble/view_models/app_view_model.dart';

class LocalStorageServiceMock extends Mock implements ILocalStorageService {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mock = LocalStorageServiceMock();

  final appViewModel = AppViewModel("loginModel", AppStore(), mock);

  group("App ViewModel Test", () {
    test("app store login model is removed at sign out", () async {
      await appViewModel.signOut();
      expect(appViewModel.appStore.loginModel, isNull);
    });

    test("login model is null when sign with null parameter", () async {
      Future future = Future<bool>.value(false);
      when(mock.put("loginModel", null)).thenAnswer((_) => future);
      await appViewModel.signIn(null);
      expect(appViewModel.appStore.loginModel, isNull);
    });
    test("login model is null on init", () async {
      Future future = Future<String>.value("");
      when(mock.get("loginModel")).thenAnswer((_) => future);
      await appViewModel.initStoredLogin();
      expect(appViewModel.appStore.loginModel, isNull);
    });
    test("init stored login with success", () async {
      Future future = Future<String>.value(json.encode({
        'access_token':
            '98d6f81088bafa64b6daa413165b81a8756874664284692f4ad12bf5cb15a24b',
        'token_type': 'bearer',
        'scope': 'public upload'
      }));
      when(mock.get("loginModel")).thenAnswer((_) => future);
      await appViewModel.initStoredLogin();
      expect(appViewModel.appStore.loginModel, isA<LoginModel>());
    });
  });
}
