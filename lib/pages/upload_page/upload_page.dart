import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/pages/upload_page/components/remove_shot_image_button.dart';
import 'package:simple_dri3ble/pages/upload_page/components/shot_description_text_form_field.dart';
import 'package:simple_dri3ble/pages/upload_page/components/shot_title_text_form_field.dart';
import 'package:simple_dri3ble/pages/upload_page/components/upload_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_dri3ble/repositories/dribbble_shots_repository.dart';
import 'package:simple_dri3ble/services/dio_http_client_service.dart';
import 'package:simple_dri3ble/view_models/upload_shot_view_model.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  ShotModel _shotModel = ShotModel();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UploadShotViewModel _uploadShotViewModel = UploadShotViewModel(
    DribbbleShotsRepository(DioHttpClientService()),
  );

  @override
  void initState() {
    super.initState();
    _uploadShotViewModel.isUploadedOutput.listen((uploaded) {
      if (uploaded) {
        Navigator.pop(context);
      } else {
        showNotUploadedShotMessage();
      }
    });
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
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 1.5, color: Colors.black26),
              ),
              child: _shotModel.images.isNotEmpty
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(
                          File(_shotModel.images.first),
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            child: StreamBuilder<bool>(
                              stream: _uploadShotViewModel.isUploadingOutput,
                              builder: (_, snapshot) {
                                return RemoveShotImageButton(
                                  enabled: snapshot.data != null
                                      ? !snapshot.data
                                      : true,
                                  onPressed: handleRemoveShotImageButtonPressed,
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  : InkWell(
                      onTap: selectImage,
                      child: Center(
                        child: Text(
                          'Clique para selecionar uma imagem',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: StreamBuilder<bool>(
                      stream: _uploadShotViewModel.isUploadingOutput,
                      builder: (_, snapshot) {
                        return ShotTitleTextFormField(
                          enabled:
                              snapshot.data != null ? !snapshot.data : true,
                          onSaved: shotTitleTextFormFieldOnSaved,
                          validator: shotTitleTextFormFieldValidator,
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: StreamBuilder<bool>(
                      stream: _uploadShotViewModel.isUploadingOutput,
                      builder: (_, snapshot) {
                        return ShotDescriptionTextFormField(
                          enabled:
                              snapshot.data != null ? !snapshot.data : true,
                          onSaved: shotDescriptionTextFormFieldOnSaved,
                          validator: shotDescriptionTextFormFieldValidator,
                        );
                      },
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
      _shotModel.images.insert(0, pickedFile.path);
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
      _uploadShotViewModel.isUploadedInput.add(_shotModel);
    }
  }

  void handleRemoveShotImageButtonPressed() {
    setState(() {
      _shotModel.images.removeAt(0);
    });
  }

  void showInvalidSelectedImagesQuantityMessage() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Selecione uma imagem',
          style: Theme.of(context).snackBarTheme.contentTextStyle,
        ),
        backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
      ),
    );
  }

  void showNotUploadedShotMessage() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Ops! A imagem deve ter a dimensão 400x300.',
          style: Theme.of(context).snackBarTheme.contentTextStyle,
        ),
        backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
      ),
    );
  }

  bool isValidForm() {
    if (_formKey.currentState.validate()) {
      if (_shotModel.images.isEmpty) {
        showInvalidSelectedImagesQuantityMessage();
        return false;
      }
      return true;
    }
    return false;
  }
}
