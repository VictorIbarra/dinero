import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/providers/PreferenciasUsuario.dart';

final prefs = new PreferenciasUsuario();

final developMode = true;
// produccion
// final ip_default = 'https://wsdinero1click.prestamofeliz.com.mx:9026';
// desarrollo
final ip_default = 'http://172.25.111.102:9004';
// testing
// final ip_default = 'http://saga.prestamofeliz.com.mx:9253';
 
final ip = prefs.ip;
String api_url = ip + '/api/UsuarioCliente';

void setApi(){
  api_url = prefs.ip + '/api/UsuarioCliente';
}

final headers = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
};

final pfVerde = Color(0xFF21D702);
final pfAzul = Color(0xFF007DEB);
final pfRojo = Color(0xFFF42F2F);
final pfGris = Color(0xFFABABAB);
final pfNaranja = Color(0xFFFD9027);
final pfAzulDeep = Color(0xFF0603AD);

final kBoxDecorationStyle = BoxDecoration(
    border: Border.all(
      width: 1.0,
      color: pfAzulDeep,
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(5.0) //         <--- border radius here
    ),
  );

final kLabelStyle = TextStyle(
  color: pfAzulDeep,//Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
);

final kHintTextStyle = TextStyle(
  color: Colors.grey,//.white54,
  fontFamily: 'Montserrat',
);




final kLabelHeader = TextStyle(
             color: pfAzul,
             fontSize: 30.0,
             fontWeight: FontWeight.w900,
             fontFamily: 'Montserrat',
             );


final kLabelMiniHeader = TextStyle(
             color: pfGris,
             //fontSize: 30.0,
             fontWeight: FontWeight.normal,
             fontFamily: 'Montserrat',
             );

final kLabelTinyHeader = TextStyle(
             color: pfGris,
             //fontSize: 30.0,
             fontSize: 12,
             fontWeight: FontWeight.normal,
             fontFamily: 'Montserrat',
             );








final kLabelTerminosCondiciones = TextStyle(
             color: pfGris,
             fontSize: 12.0,
             fontWeight: FontWeight.normal,
             fontFamily: 'Montserrat',
             );

final kLabelPerfilOpcion = TextStyle(
             color: Colors.black,
             fontSize: 15.0,
             fontWeight: FontWeight.normal,
             fontFamily: 'Montserrat',
             );