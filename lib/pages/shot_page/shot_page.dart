import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/pages/shot_page/components/shot_image_thumbnail.dart';
import 'package:simple_dri3ble/pages/shot_page/components/shot_page_header.dart';

class ShotPage extends StatefulWidget {
  final ShotModel shotModel;

  ShotPage({@required this.shotModel});

  @override
  _ShotPageState createState() => _ShotPageState();
}

class _ShotPageState extends State<ShotPage> {
  ShotModel _shotModel;
  List<String> _imagesUrl;
  CarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    _shotModel = widget.shotModel;
    _imagesUrl = <String>[
      _shotModel.images.hidpi,
      _shotModel.images.normal,
      _shotModel.images.teaser
    ];
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.shotModel.title)),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        children: [
          ShotPageHeader(shotModel: _shotModel),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                enlargeCenterPage: false,
                viewportFraction: 1.0,
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              items: _imagesUrl.map((e) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: CachedNetworkImage(
                        imageUrl: e,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _imagesUrl
                  .map(
                    (e) => Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ShotImageThumbnail(
                          imageUrl: e,
                          onTap: () => _selectImage(
                            index: _imagesUrl.indexOf(e),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _selectImage({@required int index}) {
    _carouselController.jumpToPage(index);
  }
}
