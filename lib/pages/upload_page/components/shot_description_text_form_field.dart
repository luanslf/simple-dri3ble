import 'package:flutter/material.dart';

class ShotDescriptionTextFormField extends StatelessWidget {
  final String Function(String) validator;
  final void Function(String) onSaved;

  ShotDescriptionTextFormField(
      {@required this.validator, @required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Descrição',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          TextFormField(
            maxLines: 5,
            onSaved: onSaved,
            validator: validator,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Theme.of(context).focusColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
