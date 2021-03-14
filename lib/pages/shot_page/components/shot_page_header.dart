import 'package:flutter/material.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/pages/components/shot_feedback.dart';
import 'package:simple_dri3ble/utils/utils.dart';

class ShotPageHeader extends StatelessWidget {
  final ShotModel shotModel;

  ShotPageHeader({@required this.shotModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShotFeedback(),
            Text(
              Utils.getFormattedDate(DateTime.parse(shotModel.publishedAt)),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  shotModel.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Text(
                shotModel.description,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
