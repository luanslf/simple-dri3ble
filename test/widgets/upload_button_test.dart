import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_dri3ble/pages/upload_page/components/upload_button.dart';

main() {
  group("Upload Button Test", () {
    testWidgets("has text inside material button", (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: UploadButton(enabled: true, onPressed: null)),
      );
      expect(find.widgetWithText(MaterialButton, "PUBLICAR"), findsOneWidget);
    });
  });
}
