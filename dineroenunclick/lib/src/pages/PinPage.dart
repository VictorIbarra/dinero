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
        future: UsuarioProvider.pinUrl(Usuario.usr.clienteId, prefs.latitud, prefs.longitud),
        builder: (BuildContext context, AsyncSnapshot<PinData> snapshot) {
            if(snapshot.hasData){
              switch (snapshot.data.idEstatus){
                case 0:
                  return Container(
                    height: double.infinity,
                    child: Center(child: Text('Usuario sin una membresía', textScaleFactor: 1.5, textAlign: TextAlign.center))
                  );
                  break;
                case 1:
                  return WebView(
                    initialUrl: snapshot.data.url,
                    javascriptMode: JavascriptMode.unrestricted,
                  );
                  break;
                case 2:
                  return Container(
                    height: double.infinity,
                    child: Center(child: Text('Su membresía se encuentra vencida', textScaleFactor: 1.5, textAlign: TextAlign.center))
                  );
                  break;
                case 3:
                  return Container(
                    height: double.infinity,
                    child: Center(child: Text('Su membresía se encuentra bloqueada', textScaleFactor: 1.5, textAlign: TextAlign.center))
                  );
                  break;
                default:
                  return Container(
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        'Ocurrio un problema al obtener el estado de su membresía',
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center
                        )
                      )
                  );
              }
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

 
  
