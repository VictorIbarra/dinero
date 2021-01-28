import 'dart:async';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/UsuarioProvider.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/utilities/metodos.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PinPage extends StatefulWidget {
  const PinPage({Key key}) : super(key: key);

  @override
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> 
  with AutomaticKeepAliveClientMixin<PinPage>{
    
    Completer<WebViewController> _controller = Completer<WebViewController>();
    bool bnd = false;
    Widget _contenido = Container(
      height: 400.0,
      child: Center( child: CircularProgressIndicator())
    );

    Widget _loadUrl(BuildContext context){
      return FutureBuilder(
        future: UsuarioProvider.pinUrl(Usuario.usr.clabe, prefs.latitud, prefs.longitud),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if(snapshot.hasData){
              return WebView(
                initialUrl: snapshot.data,
                javascriptMode: JavascriptMode.unrestricted,
              );
            }
            else{
              return Container(
                height: double.infinity,
                child: Center( child: CircularProgressIndicator())
              );
            }
          },
      );
    }
    
    @override
    void initState() {
      getCurrentLocation((){
        print("LOCATION !!");
      });
      
      super.initState();
    }
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: _loadUrl(context)
      );
    }

     @override
    bool get wantKeepAlive => true;


  }

 
  
