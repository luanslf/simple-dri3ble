import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShotListItemImageThumbnail extends StatelessWidget {
  final String imageUrl;
  final double verticalMargin;
  final double horizontalMargin;

  ShotListItemImageThumbnail(
      {@required this.imageUrl,
      @required this.verticalMargin,
      @required this.horizontalMargin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: verticalMargin, horizontal: horizontalMargin),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          placeholder: (context, url) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          },
          imageUrl: imageUrl,
          width: MediaQuery.of(context).size.height / 20,
          height: MediaQuery.of(context).size.height / 20,
        ),
      ),
    );
  }
}
