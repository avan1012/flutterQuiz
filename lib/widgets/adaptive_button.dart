import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function dateHandler;
  AdaptiveButton(this.text, this.dateHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: dateHandler,
            color: Colors.purple,
            child: Text(text),
          )
        : FlatButton(
            onPressed: dateHandler,
            textColor: Colors.purple,
            child: Text(text),
          );
  }
}
