import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_dri3ble/view_models/authorizer_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizerPage extends StatefulWidget {
  @override
  _AuthorizerPageState createState() => _AuthorizerPageState();
}

class _AuthorizerPageState extends State<AuthorizerPage> {
  final AuthorizerViewModel _authorizerViewModel = AuthorizerViewModel();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: _authorizerViewModel.authorizerUrl(),
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('https://github.com/')) {
          String code = request.url.substring(request.url.indexOf('=') + 1);
          Navigator.pop(context, code);
        }
        return NavigationDecision.navigate;
      },
    );
  }
}
