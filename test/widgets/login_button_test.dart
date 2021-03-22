import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_dri3ble/pages/login_page/components/login_button.dart';

main() {
  group("Login Button Test", () {
    testWidgets("has text inside material button", (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: LoginButton(enabled: true, onPressed: null)),
      );
      expect(find.widgetWithText(MaterialButton, "ENTRAR"), findsOneWidget);
    });
  });
}
