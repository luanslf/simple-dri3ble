import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:simple_dri3ble/controllers/app_controller.dart';
import 'package:simple_dri3ble/pages/home_page/home_page.dart';
import 'package:simple_dri3ble/pages/login_page/login_page.dart';

class RootPage extends StatelessWidget {
  final appViewModel = AppController.instance.appViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          final loginModel = appViewModel.appStore.loginModel;
          if (loginModel == null) return LoginPage();
          return HomePage();
        },
      ),
    );
  }
}
