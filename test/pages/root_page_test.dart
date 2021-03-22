import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_dri3ble/pages/root_page/root_page.dart';

main() {
  group("Root Page Test", () {
    testWidgets("has Scaffold scope with a observer widget inside",
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: RootPage()));
      expect(
        find.ancestor(
          of: find.byType(Observer),
          matching: find.byType(Scaffold),
        ),
        findsOneWidget,
      );
    });
  });
}
