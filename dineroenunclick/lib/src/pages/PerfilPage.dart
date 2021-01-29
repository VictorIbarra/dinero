import 'package:flutter/material.dart';
// import 'package:dineroenunclick/src/providers/db_provider.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/widgets/modals.dart';
// import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key key}) : super(key: key);

  _PerfilPageState createState() => _PerfilPageState();
}

_itemOption(BuildContext context, String title, String goTo) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, goTo);
    },
    child: Container(
      padding: EdgeInsets.all(30.0),
      child: Text(title, style: kLabelPerfilOpcion),
    ),
  );
}

_cerrarSesion(BuildContext context) {
  return GestureDetector(
    onTap: () {
      modalConfirmacion(context, 'Salir', 'Estas seguro de cerrar sesion ?',
          () {
        //DBProvider.db.resetUsuario();
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/login');
      });
    },
    child: Container(
      child: Text(
        'Cerrar sesión',
        style: TextStyle(
          color: pfRojo,
          fontSize: 15.0,
          fontWeight: FontWeight.w800,
          fontFamily: 'Montserrat',
        ),
      ),
    ),
  );
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Perfil',
          style: TextStyle(
            color: pfAzul,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Icon(
                Icons.account_box,
                color: Colors.grey,
                size: 30.0,
              ),
              _itemOption(context, 'Información de mi cuenta', '/informacion'),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.security,
                color: Colors.grey,
                size: 30.0,
              ),
              _itemOption(context, 'Seguridad', '/seguridad'),
            ],
          ),

          Row(
            children: [
              Icon(
                Icons.phone_android,
                color: Colors.grey,
                size: 30.0,
              ),
              _itemOption(context, 'Centro de ayuda', '/ayuda'),
            ],
          ),

          // _itemOption(context, 'Mis créditos', '/misCreditos'),

          Expanded(
            child: SizedBox(),
          ),

          _cerrarSesion(context),

          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _botonTerminosYCondiciones(),
              _botonPoliticaDePrivacidad(),
            ],
          ),
          // Text('Terminos y condiciones | Politicas de privacidad', style: kLabelTerminosCondiciones,),
          SizedBox(
            height: 01.0,
          ),
          Text(
            'Préstamo Feliz 2021',
            style: kLabelTerminosCondiciones,
          ),
          SizedBox(
            height: 15.0,
          ),
          // Text(
          //   'f',
          //   style: TextStyle(
          //     color: Color(0xFF1747AC),
          //     fontSize: 25.0,
          //     fontWeight: FontWeight.w900,
          //     fontFamily: 'Montserrat',
          //   ),
          // ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  Widget _botonTerminosYCondiciones() {
    return FlatButton(
      onPressed: () {
        launch('https://www.prestamofeliz.com.mx');
      },
      padding: EdgeInsets.only(right: 0.0),
      child: Text(
        'Terminos Y Condiciones',
        style: TextStyle(fontSize: 10.0, color: Color(0xFF1747AC)),
      ),
    );
  }

  Widget _botonPoliticaDePrivacidad() {
    return FlatButton(
      onPressed: () {
        launch('https://www.prestamofeliz.com.mx');
      },
      padding: EdgeInsets.only(right: 0.0),
      child: Text(
        'Politica De Privacidad',
        style: TextStyle(fontSize: 10.0, color: Color(0xFF1747AC)),
      ),
    );
  }
}
