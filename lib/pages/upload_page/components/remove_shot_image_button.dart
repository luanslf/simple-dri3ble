import 'package:flutter/material.dart';

class RemoveShotImageButton extends StatelessWidget {
  final Function onPressed;
  final bool enabled;

  RemoveShotImageButton({@required this.onPressed, @required this.enabled});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: enabled ? onPressed : null,
      child: Icon(Icons.remove),
      mini: true,
      backgroundColor: enabled
          ? Theme.of(context).floatingActionButtonTheme.backgroundColor
          : Colors.black26,
    );
  }
}
