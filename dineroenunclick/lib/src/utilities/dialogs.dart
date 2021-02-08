import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Dialogs {
  static void alert(BuildContext context, {String title, String description}) {
    showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: description != null ? Text(description) : null,
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
