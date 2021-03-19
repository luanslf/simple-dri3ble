import 'package:simple_dri3ble/stores/app_store.dart';
import 'package:simple_dri3ble/view_models/app_view_model.dart';

class AppController {
  static final AppController instance = AppController._();
  AppController._();

  AppViewModel appViewModel = AppViewModel(AppStore());
}
