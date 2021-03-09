import 'package:dineroenunclick/src/providers/PreferenciasUsuario.dart';
import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';


class SeguridadPage extends StatefulWidget {

  
  SeguridadPage({Key key}) : super(key: key);

  _SeguridadPageState createState() => _SeguridadPageState();
}

class _SeguridadPageState extends State<SeguridadPage> {

  final prefs = new PreferenciasUsuario();
  bool _huella;

  @override
  void initState() { 
    super.initState();

    _huella = prefs.huella;
    
  }

  
  _setAccesoBiometrico(bool valor){
    prefs.huella = valor;

    setState(() {
      _huella = prefs.huella; 
      print(_huella.toString());
    });

  }



_itemOption(BuildContext context, String title, String goTo){
  final _screenSize = MediaQuery.of(context).size;

  return GestureDetector(
    onTap: (){
      Navigator.pushNamed(context, goTo);
    },
    child: Container(
      width: _screenSize.width,
      margin: EdgeInsets.only(left: 10, top: 30.0, ),
      child: Row(
        children: <Widget>[
          Text(title, style: kLabelPerfilOpcion),
        ],
      ),
    ),
  );
}

_itemSwitchOption(BuildContext context, String title, String goTo){
  final _screenSize = MediaQuery.of(context).size;
  

  return Container(
      width: _screenSize.width,
      margin: EdgeInsets.only(left: 10, top: 15.0, right: 10),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Text(title, style: kLabelPerfilOpcion),
            onTap: (){
              //Navigator.pushNamed(context, goTo);
              _setAccesoBiometrico(!_huella);
            },
          ),
          Expanded(child: SizedBox(),),
          Switch(
            value: _huella, 
            activeColor: pfAzul,
            onChanged: (newVal){
              
              _setAccesoBiometrico(newVal);
            }
          ),
        ],
      ),
    );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: pfAzul,),
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
          child: Text('Seguridad', style: TextStyle(
          color: pfazul2,
          fontSize: 19.0,
          fontWeight: FontWeight.w900,
          fontFamily: 'Montserrat',
          ),
        ),
        ),
      ),
      body: Column(
        children: <Widget>[
          _itemOption(context, 'Cambio de Contraseña', '/changePassword'),
          // _itemOption(context, 'Cambio de NIP', '/changeNIP'),
          // _itemSwitchOption(context, 'Acceso biometrico', '/ayuda'),

        ],
      ),
    );
  
  }
}