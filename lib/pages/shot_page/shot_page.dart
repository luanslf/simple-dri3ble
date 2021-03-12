import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:simple_dri3ble/models/shot_model.dart';

class ShotPage extends StatefulWidget {
  final ShotModel shotModel;

  ShotPage({@required this.shotModel});

  @override
  _ShotPageState createState() => _ShotPageState();
}

class _ShotPageState extends State<ShotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.shotModel.title)),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton.icon(
                      onPressed: null,
                      icon: Icon(Icons.favorite_border),
                      label: Text('999'),
                    ),
                    TextButton.icon(
                      onPressed: null,
                      icon: Icon(Icons.remove_red_eye_outlined),
                      label: Text('999'),
                    ),
                  ],
                ),
              ),
              Text(
                'Postado em ${widget.shotModel.publishedAt}',
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
                    widget.shotModel.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Text(
                  widget.shotModel.description,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 2.5,
                enlargeCenterPage: false,
                viewportFraction: 1.0,
              ),
              items: [
                widget.shotModel.images.hidpi,
                widget.shotModel.images.normal,
                widget.shotModel.images.teaser
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: CachedNetworkImage(
                        imageUrl: i,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
