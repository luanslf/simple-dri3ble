import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_dri3ble/pages/authorizer_page/authorizer_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

main() {
  group("Authorizer Page Test", () {
    testWidgets("has web view", (tester) async {
      await tester.pumpWidget(MaterialApp(home: AuthorizerPage()));
      expect(find.byType(WebView), findsOneWidget);
    });
  });
}
