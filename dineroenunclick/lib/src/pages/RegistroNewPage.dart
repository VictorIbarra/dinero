import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/PromocionProvider.dart';
import 'package:dineroenunclick/src/providers/RegistroProvisionalProvider.dart';
import 'package:dineroenunclick/src/providers/UsuarioProvider.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/utilities/dialogs.dart';
import 'package:dineroenunclick/src/widgets/modals.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

class RegistroNewPage extends StatefulWidget {
  RegistroNewPage({Key key}) : super(key: key);
  _RegistroNewPageState createState() => _RegistroNewPageState();
}

class _RegistroNewPageState extends State<RegistroNewPage> {
  TextEditingController _correo = TextEditingController();
  TextEditingController _rfc = TextEditingController();
  TextEditingController _celular = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _passConfirm = TextEditingController();
  String _launchUrl = 'https://dinero1click.prestamofeliz.com.mx/terminos.pdf';
  bool _value1 = false;

  Widget _buildRFCTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'RFC',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.characters,
            controller: _rfc,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Ingresa tu RFC',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Correo electrónico',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _correo,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Ingresa tu email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCelTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Número Celular',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: _celular,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Ingresa tu TELEFONO',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Contraseña',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.text,
            controller: _pass,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Ingresa tu nueva contraseña',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordConfirmTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Corfirmación',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.text,
            controller: _passConfirm,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Confirma tu contraseña',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrarseBtn(ScaffoldState contextScaffold) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: _screenSize.width * .6,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            FocusScope.of(context).requestFocus(new FocusNode());
            if (_value1) {
              print('boton rechazar oprimido ');
              if (_value1 == false) {
                Dialogs.alert(context,
                    description:
                        'Nesesitas aceptar los términos y condiciones');
              } else {
                if (_value1 == true && _pass.text == _passConfirm.text) {
                  //metodo de crear
                  final u = await RegistroProvisionalProvider.registrarUsuario(
                      _rfc.text, _correo.text, _celular.text, _pass.text);
                  if (u != null) {
                    modalLoading(context, 'Validando', true);
                    final Usuario user =
                        await UsuarioProvider.login(new Usuario(
                      correo: _correo.text,
                      pass: _pass.text,
                    ));
                    if (user.clienteId != null) {
                      PromocionProvider.cotizacionCliente(user.clienteId).then(
                          (value) => {
                                print(value),
                                Navigator.pushReplacementNamed(
                                    context, '/cliente')
                              });
                    } else {
                      contextScaffold.showSnackBar(SnackBar(
                        backgroundColor: pfNaranja,
                        content: Text('Datos incorrectos'),
                      ));
                    }
                  } else {
                    contextScaffold.showSnackBar(SnackBar(
                      backgroundColor: pfNaranja,
                      content: Text('Datos incorrectos'),
                    ));
                  }
                } else {
                  (contextScaffold).showSnackBar(SnackBar(
                    backgroundColor: pfNaranja,
                    content: Text('Las Contraseñas no coinciden.'),
                  ));
                }
              }
            } else {
              print('nesesitas ver tus notas y darle check ');
              Dialogs.alert(context,
                  description: 'Nesesitas aceptar los términos y condiciones');
            }
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: pfVerde,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Continuar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              Icon(Icons.keyboard_arrow_right, color: Colors.white)
            ],
          )),
    );
  }

  Widget _buildRegresarBtn() {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: _screenSize.width * .3,
      height: _screenSize.height * .07,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            Navigator.pop(context);
          },
          padding: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: pfVerde,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Regresar',
                style: TextStyle(
                  //color: Color(0xFFFF960A),
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
              )
            ],
          )),
    );
  }

  Widget _footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[_buildRegresarBtn()],
          ),
        ),
      ],
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            ' Nuevo Registro',
            style: TextStyle(
              color: pfGris,
              fontSize: 15.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              _buildRFCTF(),
              SizedBox(height: 10.0),
              _buildEmailTF(),
              SizedBox(height: 10.0),
              _buildCelTF(),
              SizedBox(height: 10.0),
              _buildPasswordTF(),
              SizedBox(height: 10.0),
              _buildPasswordConfirmTF(),
              SizedBox(height: 10.0),
              Row(
                children: [
                  _createChecBox(),
                  Column(
                    children: [
                      Text('Al Continuar, Aceptas Nuestros'),
                      InkWell(
                        child: Text(
                            'Términos y Condiciones y Aviso de privacidad',
                            style: TextStyle(color: Colors.redAccent[700])),
                        onTap: () {
                          _launchInBrowser(_launchUrl);
                        },
                      )
                    ],
                  ),
                ],
              ),
              _buildRegistrarseBtn(Scaffold.of(context)),
              Expanded(
                child: SizedBox(),
              ),
              _footer(context),
              SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createChecBox() {
    return Checkbox(
        value: _value1,
        activeColor: Colors.green[400],
        onChanged: (bool value) {
          setState(() {
            _value1 = value;
            print('$_value1 este es el valor pego');
          });
        });
  }
}