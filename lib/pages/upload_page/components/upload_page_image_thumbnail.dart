import 'package:flutter/material.dart';

class UploadPageImageThumbnail extends StatelessWidget {
  final String imagePath;

  UploadPageImageThumbnail({@required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width / 3.4,
      ),
    );
  }
}
