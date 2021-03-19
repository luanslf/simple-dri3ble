import 'package:simple_dri3ble/models/login_model.dart';
import 'package:mobx/mobx.dart';
part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  LoginModel loginModel;

  @action
  void setLoginModel(LoginModel loginModel) {
    this.loginModel = loginModel;
  }
}
