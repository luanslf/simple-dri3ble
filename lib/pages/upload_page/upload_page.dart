import 'package:flutter/material.dart';
import 'package:simple_dri3ble/pages/upload_page/components/shot_description_text_form_field.dart';
import 'package:simple_dri3ble/pages/upload_page/components/shot_title_text_form_field.dart';
import 'package:simple_dri3ble/pages/upload_page/components/upload_button.dart';
import 'package:simple_dri3ble/pages/upload_page/components/upload_page_image_thumbnail.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<String> _imagesPath;
  ValueNotifier<bool> _validFormListenable;
  ValueNotifier<int> _imagesPathLengthListenable;

  @override
  void initState() {
    super.initState();
    _imagesPath = List<String>();
    _validFormListenable = ValueNotifier<bool>(false);
    _imagesPathLengthListenable = ValueNotifier<int>(0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload'),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          children: [
            ValueListenableBuilder<int>(
              valueListenable: _imagesPathLengthListenable,
              builder: (_, length, __) {
                if (length < 3) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(width: 1.5, color: Colors.black26),
                    ),
                    child: InkWell(
                      onTap: selectImage,
                      child: Center(
                        child: Text(
                          'Clique para selecionar uma imagem',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            ValueListenableBuilder<int>(
              valueListenable: _imagesPathLengthListenable,
              builder: (_, length, __) {
                if (length == 0) return Container();
                return Container(
                  margin: EdgeInsets.only(top: 10.0),
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 8),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: _imagesPath
                        .map(
                          (e) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: UploadPageImageThumbnail(imagePath: e),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
            ValueListenableBuilder<int>(
              valueListenable: _imagesPathLengthListenable,
              builder: (_, length, __) {
                return Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    '$length / 3',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: length != 3 ? Colors.red : Colors.black38,
                        ),
                  ),
                );
              },
            ),
            Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: ShotTitleTextFormField(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: ShotDescriptionTextFormField(),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: ValueListenableBuilder<bool>(
                valueListenable: _validFormListenable,
                builder: (_, valid, __) {
                  return UploadButton(enabled: valid);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    bool pop = await showDialog(
      context: (context),
      builder: (context) {
        return AlertDialog(
          title: Text('Cancelar postagem?'),
          content: Text('As informações inseridas não serão salvas'),
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Não'),
            ),
            FlatButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
    return pop;
  }

  Future<void> selectImage() async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      _imagesPath.add(pickedFile.path);
      _imagesPathLengthListenable.value = _imagesPath.length;
    });
  }
}
