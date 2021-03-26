//https://mid-interactive.com/TerminosYCondicionesPeru.html

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/providers/UsuarioProvider.dart';

class TerminosPage extends StatefulWidget {
  TerminosPage({Key key}) : super(key: key);

  _TerminosPageState createState() => _TerminosPageState();
}

Widget _loadTerminos(BuildContext context){
  return FutureBuilder(
    future: UsuarioProvider.terminosCondiciones(),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if(snapshot.hasData){
          return WebView(
            initialUrl: snapshot.data,
            javascriptMode: JavascriptMode.unrestricted,
          );
        }
        else{
          return Container(
            height: 400.0,
            child: Center( child: CircularProgressIndicator())
          );
        }
      },
  );
}

class _TerminosPageState extends State<TerminosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        //automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: pfVerde,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.arrow_back_ios, ),
          Icon(Icons.arrow_back_ios, ),
        ],
        title: Center(
          child: Text('Terminos y Condiciones', style: TextStyle(
          color: pfGris,
          fontSize: 15.0,
          fontWeight: FontWeight.w900,
          fontFamily: 'Montserrat',
          ),
        ),
        ),
      ),
      body: _loadTerminos(context),
    );
  
  }
}