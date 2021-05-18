import 'package:flutter/material.dart';

modalConfirmacion(BuildContext context, String titulo, String mensaje, Function() si) async {
    
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(titulo),
            content: Container(
              child: Text(mensaje),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('NO'),
                onPressed: () {
                  Navigator.pop(context);
                 },
              ),
              new FlatButton(
                child: new Text('SI'),
                onPressed: () {
                  si();
                 },
              )
            ],
          );
        });
  }

modalInput(BuildContext context, GlobalKey<FormState> _key, TextInputType _typeInput, bool secret, String titulo, String hint, String textoNo, String textoSi, Function no, Function si) async {
    
    TextEditingController _controller = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(titulo),
            content: Form(
              key: _key,
              child: TextFormField(
                obscureText: secret,
                keyboardType: _typeInput,
                autofocus: true,
                controller: _controller,
                decoration: InputDecoration(hintText: hint),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(textoNo),
                onPressed: () {
                  if(no == null){
                    Navigator.pop(context);
                  }
                  else{
                    no();
                  }
                  
                },
              ),
              new FlatButton(
                child: new Text(textoSi),
                onPressed: () {
                  si(_controller.text);
                },
              )
            ],
          );
        });
  }

Future<T> modalLoading<T>(BuildContext context, String titulo, bool linearLoader) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child:  Text(titulo)
          ),
          content: Container(
            child: linearLoader ? LinearProgressIndicator() : CircularProgressIndicator(),
          ),
        );
      }
    );
  }