import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cool_alert/cool_alert.dart';

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
      CoolAlert.show(
        backgroundColor: pfazul2,
          context: context,
          type: CoolAlertType.confirm,
          title: '',
          text: 'Estas seguro de cerrar la sesion?',
          confirmBtnText: "Si",
          onConfirmBtnTap: () {
            print('cerrar sesion');
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/login');
          },
          cancelBtnText: "No",
          confirmBtnColor: Colors.red[700]);
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
           backgroundColor: Colors.white,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: pfazul2,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
         
          automaticallyImplyLeading: false,
          title: Text(
            'Perfil',
            style: TextStyle(
              color: pfazul2,
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.account_box,
                    color: Colors.grey,
                    size: 30.0,
                  ),
                  _itemOption(
                      context, 'Información de mi cuenta', '/informacion'),
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

              new Image.asset(
                'assets/prestamo.png',
                height: 60.0,
                fit: BoxFit.cover,
              ),

              SizedBox(
                height: 80.0,
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
              _botonPrestamoFeliz(),
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
        ));
  }

  Widget _botonTerminosYCondiciones() {
    return FlatButton(
      onPressed: () {
        launch('https://dinero1click.prestamofeliz.com.mx/terminos.pdf');
      },
      padding: EdgeInsets.only(right: 0.0),
      child: Text(
        'Terminos Y Condiciones',
        style: TextStyle(fontSize: 12.0, color: pfazul2),
      ),
    );
  }

  Widget _botonPoliticaDePrivacidad() {
    return FlatButton(
      onPressed: () {
        launch('https://dinero1click.prestamofeliz.com.mx/aviso.pdf');
      },
      padding: EdgeInsets.only(right: 0.0),
      child: Text(
        'Politica De Privacidad',
        style: TextStyle(fontSize: 12.0, color: pfazul2),
      ),
    );
  }

  Widget _botonPrestamoFeliz() {
    return FlatButton(
      onPressed: () {
        launch('https://www.prestamofeliz.com.mx/');
      },
      padding: EdgeInsets.only(right: 0.0),
      child: Text(
        'PRESTAMO FELIZ',
        style: TextStyle(fontSize: 15.0, color: pfazul2),
      ),
    );
  }
}