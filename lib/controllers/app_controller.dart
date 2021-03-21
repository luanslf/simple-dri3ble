import 'package:simple_dri3ble/services/shared_preferences_local_storage_service.dart';
import 'package:simple_dri3ble/stores/app_store.dart';
import 'package:simple_dri3ble/utils/constants.dart';
import 'package:simple_dri3ble/view_models/app_view_model.dart';

class AppController {
  static final AppController instance = AppController._();
  AppController._() {
    appViewModel.initStoredLogin();
  }

  AppViewModel appViewModel = AppViewModel(Constants.loginStorageKey,
      AppStore(), SharedPreferencesLocalStorageService());

  String get accessToken => appViewModel.appStore.loginModel.accessToken;
}
