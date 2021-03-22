import 'package:flutter/material.dart';
import 'package:simple_dri3ble/controllers/app_controller.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/pages/home_page/components/shot_list_item.dart';
import 'package:simple_dri3ble/pages/upload_page/upload_page.dart';
import 'package:simple_dri3ble/repositories/dribbble_shots_repository.dart';
import 'package:simple_dri3ble/services/dio_http_client_service.dart';
import 'package:simple_dri3ble/services/io_connection_checker_service.dart';
import 'package:simple_dri3ble/services/shared_preferences_local_storage_service.dart';
import 'package:simple_dri3ble/utils/constants.dart';
import 'package:simple_dri3ble/view_models/shots_view_model.dart';
import 'package:simple_dri3ble/view_models/upload_shot_view_model.dart';

class HomePage extends StatefulWidget {
  final String accessToken;

  HomePage({this.accessToken});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ShotsViewModel _shotsViewModel = ShotsViewModel(
    Constants.shotsStorageKey,
    DribbbleShotsRepository(DioHttpClientService()),
    SharedPreferencesLocalStorageService(),
    IOConnectionCheckerService(),
  );

  UploadShotViewModel _uploadShotViewModel;

  /* final UploadShotViewModel _uploadShotViewModel = UploadShotViewModel(
    AppController.instance.accessToken,
    Constants.offlineShotsStorageKey,
    DribbbleShotsRepository(DioHttpClientService()),
    SharedPreferencesLocalStorageService(),
    IOConnectionCheckerService(),
  ); */

  @override
  void initState() {
    super.initState();
    _uploadShotViewModel = UploadShotViewModel(
      widget.accessToken ?? AppController.instance.accessToken,
      Constants.offlineShotsStorageKey,
      DribbbleShotsRepository(DioHttpClientService()),
      SharedPreferencesLocalStorageService(),
      IOConnectionCheckerService(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    uploadOfflineShots();
    //loadShots();
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
            onPressed: handleExitButtonPressed,
          ),
        ],
      ),
      floatingActionButton: ValueListenableBuilder<List<ShotModel>>(
        valueListenable: _shotsViewModel.shots,
        builder: (_, shots, __) {
          if (shots == null) return Container();
          return FloatingActionButton(
            onPressed: goToUploadPage,
            child: Icon(Icons.add),
          );
        },
      ),
      body: StreamBuilder<bool>(
        initialData: true,
        stream: _uploadShotViewModel.isUploadingOutput,
        builder: (_, snapshot) {
          bool uploading = snapshot.data;
          if (uploading) return Center(child: CircularProgressIndicator());
          loadShots();
          return ValueListenableBuilder<List<ShotModel>>(
            valueListenable: _shotsViewModel.shots,
            builder: (_, shots, __) {
              if (shots == null)
                return Center(child: CircularProgressIndicator());
              if (shots.isEmpty) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Nenhuma postagem encontrada',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  children:
                      shots.map((e) => ShotListItem(shotModel: e)).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<Null> onRefresh() async {
    //await Future.delayed(Duration(seconds: 1));
    uploadOfflineShots();
    //loadShots();
  }

  void loadShots() {
    String accessToken = AppController.instance.accessToken;
    _shotsViewModel.getShots(accessToken);
  }

  void uploadOfflineShots() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _uploadShotViewModel.uploadOfflineShots();
    });
  }

  void goToUploadPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => UploadPage()));
  }

  void handleExitButtonPressed() {
    AppController.instance.appViewModel.signOut();
  }
}
