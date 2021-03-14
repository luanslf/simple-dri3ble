import 'package:flutter/material.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/pages/home_page/components/shot_list_item.dart';
import 'package:simple_dri3ble/pages/upload_page/upload_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ShotModel shotModelExample;
  List<ShotModel> _shots = List<ShotModel>();

  @override
  void initState() {
    super.initState();
    shotModelExample = ShotModel.fromJson({
      "id": 471756,
      "title": "Sasquatch",
      "description":
          "<p>Quick, messy, five minute sketch of something that might become a fictional something.</p>",
      "images": {
        "hidpi": "https://picsum.photos/id/1/300/200",
        "normal": "https://picsum.photos/700/500",
        "teaser": "https://picsum.photos/200/300"
      },
      "published_at": "2012-03-15T01:52:33Z",
      "updated_at": "2012-03-15T02:12:57Z",
      "tags": ["fiction", "sasquatch", "sketch", "wip"],
      "attachments": [
        {
          "id": 206165,
          "url": "https://picsum.photos/id/1/300/200",
          "thumbnail_url": "https://picsum.photos/id/1/300/200",
          "size": 116375,
          "content_type": "image/jpeg",
          "created_at": "2014-02-07T16:35:09Z"
        }
      ],
      "low_profile": false
    });
    _shots = [shotModelExample];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple Dribbble',
          style: Theme.of(context).appBarTheme.textTheme.headline5,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToUploadPage,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _shots.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        itemBuilder: (context, index) {
          return ShotListItem(shotModel: _shots[index]);
        },
      ),
    );
  }

  void goToUploadPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => UploadPage()));
  }
}
