import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_dri3ble/pages/components/shot_feedback.dart';

main() {
  group("Shot Feedback Test", () {
    testWidgets("has one favorite border icon", (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: ShotFeedback(likes: 5, views: 5)),
      );
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });
    testWidgets("has one remove red eye outlined icon", (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: ShotFeedback(likes: 5, views: 5)),
      );
      expect(find.byIcon(Icons.remove_red_eye_outlined), findsOneWidget);
    });
  });
}
