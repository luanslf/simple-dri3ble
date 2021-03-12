import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => {},
      color: Theme.of(context).buttonColor,
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
