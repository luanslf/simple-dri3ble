import 'package:flutter/material.dart';
import 'package:simple_dri3ble/pages/authorizer_page/authorizer_page.dart';
import 'package:simple_dri3ble/pages/login_page/components/login_button.dart';
import 'package:simple_dri3ble/view_models/login_view_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel _loginViewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            LoginButton(onPressed: authorizeFromWebView),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  Future<void> authorizeFromWebView() async {
    String code = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => AuthorizerPage()));
    if (code != null) {
      print(code);
    }
  }
}
