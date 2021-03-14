import 'package:flutter/material.dart';

class ShotFeedback extends StatelessWidget {
  final int views;
  final int likes;

  ShotFeedback({this.views: 999, this.likes: 999});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            onPressed: null,
            icon: Icon(Icons.favorite_border, color: Colors.red),
            label: Text(likes.toString()),
          ),
          TextButton.icon(
            onPressed: null,
            icon: Icon(Icons.remove_red_eye_outlined, color: Color(0xFFFF0081)),
            label: Text(views.toString()),
          ),
        ],
      ),
    );
  }
}
