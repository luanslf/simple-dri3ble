import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_dri3ble/pages/upload_page/components/shot_description_text_form_field.dart';
import 'package:simple_dri3ble/pages/upload_page/components/shot_title_text_form_field.dart';
import 'package:simple_dri3ble/pages/upload_page/components/upload_button.dart';
import 'package:simple_dri3ble/pages/upload_page/upload_page.dart';

main() {
  group("Upload Page Test", () {
    testWidgets("has app bar with title page", (tester) async {
      await tester.pumpWidget(MaterialApp(home: UploadPage(accessToken: "")));
      expect(find.widgetWithText(AppBar, "Upload"), findsOneWidget);
    });
    testWidgets("has form widget inside list view", (tester) async {
      await tester.pumpWidget(MaterialApp(home: UploadPage(accessToken: "")));
      expect(
        find.ancestor(of: find.byType(Form), matching: find.byType(ListView)),
        findsOneWidget,
      );
    });
    testWidgets("has description field inside form widget", (tester) async {
      await tester.pumpWidget(MaterialApp(home: UploadPage(accessToken: "")));
      expect(
        find.ancestor(
          of: find.byType(ShotDescriptionTextFormField),
          matching: find.byType(Form),
        ),
        findsOneWidget,
      );
    });
    testWidgets("has title field inside form widget", (tester) async {
      await tester.pumpWidget(MaterialApp(home: UploadPage(accessToken: "")));
      expect(
        find.ancestor(
          of: find.byType(ShotTitleTextFormField),
          matching: find.byType(Form),
        ),
        findsOneWidget,
      );
    });
    testWidgets("has upload button inside list view", (tester) async {
      await tester.pumpWidget(MaterialApp(home: UploadPage(accessToken: "")));
      expect(
        find.ancestor(
          of: find.byType(UploadButton),
          matching: find.byType(ListView),
        ),
        findsOneWidget,
      );
    });
    testWidgets("has pick image button", (tester) async {
      await tester.pumpWidget(MaterialApp(home: UploadPage(accessToken: "")));
      expect(
        find.widgetWithText(InkWell, "Clique para selecionar uma imagem"),
        findsOneWidget,
      );
    });
  });
}
