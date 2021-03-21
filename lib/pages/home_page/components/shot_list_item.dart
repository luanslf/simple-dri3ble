import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/pages/components/shot_feedback.dart';
import 'package:simple_dri3ble/pages/shot_page/shot_page.dart';

class ShotListItem extends StatelessWidget {
  final ShotModel shotModel;

  ShotListItem({@required this.shotModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () => detailShot(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.transparent),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.fill,
                      placeholder: (context, url) {
                        return Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          'assets/images/picture.png',
                          fit: BoxFit.contain,
                        );
                      },
                      imageUrl: shotModel.images.first,
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    /* Align(
                      alignment: Alignment.topRight,
                      child: ShotListItemImageThumbnail(
                        imageUrl: shotModel.images.normal,
                        verticalMargin: 28.0,
                        horizontalMargin: 14.0,
                      ),
                    ), */
                    /* Align(
                      alignment: Alignment.topRight,
                      child: ShotListItemImageThumbnail(
                        imageUrl: shotModel.images.teaser,
                        verticalMargin: 20.0,
                        horizontalMargin: 20.0,
                      ),
                    ), */
                  ],
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shotModel.title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                ShotFeedback(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void detailShot(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => ShotPage(shotModel: shotModel)));
  }
}
