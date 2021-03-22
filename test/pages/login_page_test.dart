import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_dri3ble/pages/authorizer_page/authorizer_page.dart';
import 'package:simple_dri3ble/pages/login_page/components/login_button.dart';
import 'package:simple_dri3ble/pages/login_page/login_page.dart';

main() {
  group("Login Page Test", () {
    testWidgets("has app title and login button", (tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));
      expect(find.text("Simple Dribbble"), findsOneWidget);
      expect(find.widgetWithText(LoginButton, "ENTRAR"), findsOneWidget);
    });

    testWidgets("login button click", (tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));
      await tester.tap(find.byType(LoginButton));
      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.byType(AuthorizerPage), findsOneWidget);
    });
  });
}
