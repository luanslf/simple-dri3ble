import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
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
                      imageUrl: shotModel.images.normal,
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        //color: Colors.red,
                        //width: MediaQuery.of(context).size.height / 20,
                        //height: MediaQuery.of(context).size.height / 20,
                        margin: EdgeInsets.symmetric(
                            vertical: 28.0, horizontal: 14.0),
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
                            imageUrl: shotModel.images.teaser,
                            width: MediaQuery.of(context).size.height / 20,
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        //color: Colors.red,
                        //width: MediaQuery.of(context).size.height / 20,
                        //height: MediaQuery.of(context).size.height / 20,
                        margin: EdgeInsets.all(20.0),
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
                            imageUrl: shotModel.images.hidpi,
                            width: MediaQuery.of(context).size.height / 20,
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                        ),
                      ),
                    ),
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
                )
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
