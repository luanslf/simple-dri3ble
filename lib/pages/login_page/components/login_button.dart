import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function onPressed;
  final bool enabled;

  LoginButton({@required this.enabled, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enabled ? onPressed : null,
      color: Theme.of(context).buttonColor,
      disabledColor: Theme.of(context).disabledColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        'ENTRAR',
        style: Theme.of(context).textTheme.headline5.copyWith(
              color: Theme.of(context).textTheme.button.color,
            ),
      ),
    );
  }
}
