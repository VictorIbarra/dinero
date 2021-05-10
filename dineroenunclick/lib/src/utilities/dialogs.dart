import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Dialogs {
  static void alert(BuildContext context, {String title, String description}) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
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

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              key: key,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Por favor espere...'),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Future<void> showConfirmationDialog(BuildContext context,
      {String phone, Function action}) async {
    final _formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          title: Text('¿Tu teléfono sigue siendo este?'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              textCapitalization: TextCapitalization.characters,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              autofocus: true,
              validator: (value) {
                if (value.isEmpty || value.length != 10) return '10 digitos';
                return null;
              },
              decoration: InputDecoration(hintText: '10 digitos'),
              onChanged: (value) => phone = value,
              initialValue: phone,
            ),
          ),
          actions: [
            FlatButton(
              child: Text('ACEPTAR'),
              onPressed: () {
                if (_formKey.currentState.validate()) action();
              },
            ),
          ],
        );
      },
    );
  }
}
