import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_dri3ble/controllers/app_controller.dart';
import 'package:simple_dri3ble/models/login_model.dart';
import 'package:simple_dri3ble/models/request_login_model.dart';
import 'package:simple_dri3ble/pages/authorizer_page/authorizer_page.dart';
import 'package:simple_dri3ble/pages/login_page/components/login_button.dart';
import 'package:simple_dri3ble/utils/constants.dart';
import 'package:simple_dri3ble/view_models/login_view_model.dart';

import '../../repositories/dribbble_shots_repository.dart';
import '../../services/dio_http_client_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  StreamSubscription _subscription;
  final LoginViewModel _loginViewModel = LoginViewModel(
    DribbbleShotsRepository(DioHttpClientService()),
  );

  @override
  void initState() {
    super.initState();
    _subscription = _loginViewModel.isAuthenticatedOutput
        .listen(AppController.instance.appViewModel.signIn);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              AppController.instance.appViewModel.signIn(
                LoginModel.fromJson(
                  {
                    'access_token':
                        '98d6f81088bafa64b6daa413165b81a8756874664284692f4ad12bf5cb15a24b',
                    'token_type': 'bearer',
                    'scope': 'public upload'
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Simple Dribbble',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            StreamBuilder<bool>(
              initialData: false,
              stream: _loginViewModel.isAuthenticatingOutput,
              builder: (_, snapshot) {
                bool enabled = !snapshot.data;
                return LoginButton(
                  onPressed: handleLoginButtonPressed,
                  enabled: enabled,
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  Future<void> handleLoginButtonPressed() async {
    String code = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => AuthorizerPage()));
    if (code != null) {
      RequestLoginModel requestLoginModel =
          RequestLoginModel(Constants.client_id, Constants.client_secret, code);
      _loginViewModel.isAuthenticatedInput.add(requestLoginModel);
    }
  }
}
