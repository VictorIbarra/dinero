import 'package:dineroenunclick/src/utilities/constants.dart';
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
          title: Column(
            children: [
              Text('Hola Alfonso', style: TextStyle(color: pfazul2)),
              Text(
                '¿Este sigue siendo tu número celular?',
                style: TextStyle(color: Colors.grey[700], fontSize: 13.0),
              ),
            ],
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              style: TextStyle(fontSize: 18, color: pfazul2),
              decoration: const InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 15, top: 8, right: 15, bottom: 0),
                hintText: '10 digitos',
              ),
              autofocus: true,
              textAlign: TextAlign.center,
              textCapitalization: TextCapitalization.characters,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value.isEmpty || value.length != 10) return '10 digitos';
                return null;
              },
              onChanged: (value) => phone = value,
              initialValue: phone,
            ),
          ),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('          Aceptar         '),
                  onPressed: () {
                    if (_formKey.currentState.validate()) action();
                  },
                ),
                Text('               ')
              ],
            ),
          ],
        );
      },
    );
  }
}