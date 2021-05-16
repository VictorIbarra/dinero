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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.account_box,
                    color: pfazul2,
                    size: 30.0,
                  ),
                  _itemOption(context, 'Información de cuenta', '/informacion'),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: pfazul2,
                    size: 20.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.security,
                    color: pfazul2,
                    size: 30.0,
                  ),
                  _itemOption(context, 'Seguridad', '/seguridad'),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: pfazul2,
                    size: 20.0,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.phone_android,
                    color: pfazul2,
                    size: 30.0,
                  ),
                  _itemOption(context, 'Centro de ayuda', '/ayuda'),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: pfazul2,
                    size: 20.0,
                  ),
                ],
              ),
              // Expanded(
              //   child: SizedBox(),
              // ),
              SizedBox(
                height: 80.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Visita nuestra',
                    style: TextStyle(fontSize: 10.0),
                  ),
                  _botonPrestamoFeliz(),
                ],
              ),
              new Image.asset(
                'assets/prestamo.png',
                height: 45.0,
                fit: BoxFit.cover,
              ),

              SizedBox(
                height: 30.0,
              ),

              Text(
                'Dinero en un Click es una marca registrada propiedad de Préstamo feliz',
                style: TextStyle(fontSize: 10.0, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _botonTerminosYCondiciones(),
                  _botonPoliticaDePrivacidad(),
                ],
              ),
              _cerrarSesion(context),
              SizedBox(
                height: 15.0,
              ),
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
        style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
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
        style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
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
        'pagina web',
        style: TextStyle(fontSize: 15.0, color: Colors.grey[700]),
      ),
    );
  }
}
