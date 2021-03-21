import 'dart:convert';
import 'package:simple_dri3ble/interfaces/services/local_storage_service_interface.dart';
import 'package:simple_dri3ble/models/login_model.dart';
import 'package:simple_dri3ble/stores/app_store.dart';

class AppViewModel {
  final String loginStorageKey;
  final AppStore appStore;
  final ILocalStorageService localStorageService;

  AppViewModel(this.loginStorageKey, this.appStore, this.localStorageService);

  Future<void> signOut() async {
    appStore.setLoginModel(null);
    await localStorageService.clear();
    //await localStorageService.delete(loginStorageKey);
  }

  Future<void> signIn(LoginModel loginModel) async {
    appStore.setLoginModel(loginModel);
    await localStorageService.put(loginStorageKey, json.encode(loginModel));
  }

  Future<void> initStoredLogin() async {
    String json = await localStorageService.get(loginStorageKey);
    if (json.isNotEmpty) {
      LoginModel loginModel = LoginModel.fromJson(jsonDecode(json));
      this.signIn(loginModel);
    }
  }
}
