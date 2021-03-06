import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final bool enabled;
  final Function onPressed;

  UploadButton({@required this.enabled, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enabled ? onPressed : null,
      color: Theme.of(context).buttonColor,
      disabledColor: Theme.of(context).disabledColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        'PUBLICAR',
        style: Theme.of(context).textTheme.headline5.copyWith(
              color: Theme.of(context).textTheme.button.color,
            ),
      ),
    );
  }
}
