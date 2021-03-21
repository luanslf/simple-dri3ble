import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShotImageThumbnail extends StatelessWidget {
  final Function onTap;
  final String imageUrl;

  ShotImageThumbnail({@required this.imageUrl, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: CachedNetworkImage(
          width: double.infinity,
          imageUrl: imageUrl,
          height: MediaQuery.of(context).size.height / 8,
          fit: BoxFit.fill,
          errorWidget: (context, url, error) {
            return Image.asset(
              'assets/images/picture.png',
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}
