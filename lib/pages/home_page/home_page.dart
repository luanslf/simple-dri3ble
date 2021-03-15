import 'package:flutter/material.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/pages/home_page/components/shot_list_item.dart';
import 'package:simple_dri3ble/pages/upload_page/upload_page.dart';
import 'package:simple_dri3ble/repositories/dribbble_shots_repository.dart';
import 'package:simple_dri3ble/services/dio_http_client_service.dart';
import 'package:simple_dri3ble/view_models/shots_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ShotsViewModel _shotsViewModel =
      ShotsViewModel(DribbbleShotsRepository(DioHttpClientService()));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shotsViewModel.getShots();
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
      body: ValueListenableBuilder<List<ShotModel>>(
        valueListenable: _shotsViewModel.shots,
        builder: (_, shots, __) {
          if (shots == null) return Center(child: CircularProgressIndicator());
          if (shots.isEmpty) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                'Nenhuma postagem encontrada',
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }
          return ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            children: shots.map((e) => ShotListItem(shotModel: e)).toList(),
          );
        },
      ),
    );
  }

  void goToUploadPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => UploadPage()));
  }
}
