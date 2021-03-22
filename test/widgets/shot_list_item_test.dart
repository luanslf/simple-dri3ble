import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/pages/components/shot_feedback.dart';
import 'package:simple_dri3ble/pages/home_page/components/shot_list_item.dart';

main() {
  group("Home List Item Test", () {
    ShotModel shotModel = ShotModel.fromJson({
      "id": 10,
      "title": "title",
      "description": "description",
      "images": {"0": ""}
    });

    testWidgets("has shot feedback widget inside", (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ShotListItem(shotModel: shotModel))),
      );
      expect(find.byType(ShotFeedback), findsOneWidget);
    });
    testWidgets("has column inside inkwell widget", (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ShotListItem(shotModel: shotModel))),
      );
      expect(
        find.ancestor(of: find.byType(Column), matching: find.byType(InkWell)),
        findsOneWidget,
      );
    });
    testWidgets("has cached network image inside tree", (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ShotListItem(shotModel: shotModel))),
      );
      expect(
        find.ancestor(
          of: find.byType(CachedNetworkImage),
          matching: find.ancestor(
            of: find.byType(Stack),
            matching: find.byType(ClipRRect),
          ),
        ),
        findsOneWidget,
      );
    });
  });
}
