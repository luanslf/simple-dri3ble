import 'package:flutter/material.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/pages/upload_page/components/shot_description_text_form_field.dart';
import 'package:simple_dri3ble/pages/upload_page/components/shot_title_text_form_field.dart';
import 'package:simple_dri3ble/pages/upload_page/components/upload_button.dart';
import 'package:simple_dri3ble/pages/upload_page/components/upload_page_image_thumbnail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_dri3ble/view_models/upload_shot_view_model.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  ShotModel _shotModel;
  List<String> _imagesPath;
  ValueNotifier<int> _imagesPathLengthListenable;
  GlobalKey<FormState> _formKey;
  UploadShotViewModel _uploadShotViewModel;
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _shotModel = ShotModel();
    _imagesPath = List<String>();
    _formKey = GlobalKey<FormState>();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _imagesPathLengthListenable = ValueNotifier<int>(0);
    _uploadShotViewModel = UploadShotViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    _uploadShotViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
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
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: ShotTitleTextFormField(
                      onSaved: shotTitleTextFormFieldOnSaved,
                      validator: shotTitleTextFormFieldValidator,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: ShotDescriptionTextFormField(
                      onSaved: shotDescriptionTextFormFieldOnSaved,
                      validator: shotDescriptionTextFormFieldValidator,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: StreamBuilder<bool>(
                initialData: false,
                stream: _uploadShotViewModel.isUploadingOutput,
                builder: (_, snapshot) {
                  bool enabled = !snapshot.data;
                  return UploadButton(
                    enabled: enabled,
                    onPressed: handleUploadButtonPressed,
                  );
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

  void shotTitleTextFormFieldOnSaved(String value) {
    _shotModel.title = value;
  }

  void shotDescriptionTextFormFieldOnSaved(String value) {
    _shotModel.description = value;
  }

  String shotTitleTextFormFieldValidator(String value) {
    if (value.isEmpty) return 'Campo obrigatório';
    return null;
  }

  String shotDescriptionTextFormFieldValidator(String value) {
    if (value.isEmpty) return 'Campo obrigatório';
    return null;
  }

  void handleUploadButtonPressed() {
    bool validForm = isValidForm();
    if (validForm) {
      _formKey.currentState.save();
      _uploadShotViewModel.upload(true);
    }
  }

  void showInvalidSelectedImagesQuantityMessage() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Selecione três imagens',
          style: Theme.of(context).snackBarTheme.contentTextStyle,
        ),
        backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
      ),
    );
  }

  bool isValidForm() {
    if (_formKey.currentState.validate()) {
      if (_imagesPath.length != 3) {
        showInvalidSelectedImagesQuantityMessage();
        return false;
      }
      return true;
    }
    return false;
  }
}
