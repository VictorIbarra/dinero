import 'package:dineroenunclick/src/models/RegistroModel.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/UsuarioProvider.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/utilities/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

class RegistroPage extends StatefulWidget {
  RegistroPage({Key key}) : super(key: key);
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage>
       with SingleTickerProviderStateMixin{
  TextEditingController _correo = TextEditingController();
  TextEditingController _rfc = TextEditingController();
  TextEditingController _celular = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _passConfirm = TextEditingController();
  String _launchUrl = 'https://dinero1click.prestamofeliz.com.mx/terminos.pdf';
  bool _value1 = false;
  bool _obscureText = true;

  FocusScopeNode _focusNode;
  AnimationController _controller;
  Animation _animation;

   @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 200.0, end: 100.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildRFCTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onEditingComplete: () => _focusNode.nextFocus(),
            textInputAction: TextInputAction.next,
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
              hintText: 'RFC',
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
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onEditingComplete: () => _focusNode.nextFocus(),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            controller: _correo,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Correo electrónico',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCelularTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onEditingComplete: () => _focusNode.nextFocus(),
            textInputAction: TextInputAction.next,
             keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
            controller: _celular,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Número celular',
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
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
             onEditingComplete: () => _focusNode.nextFocus(),
            obscureText: _obscureText,
            onChanged: (val) {
              setState(() {});
            },
            keyboardType: TextInputType.text,
            controller: _pass,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Contraseña',
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
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onEditingComplete: () => _focusNode.unfocus(),
            textInputAction: TextInputAction.done,
            obscureText: _obscureText,
            onChanged: (val) {
              setState(() {});
            },
            keyboardType: TextInputType.text,
            controller: _passConfirm,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _togglePasswordStatus,
                color: Colors.green,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0, top: 10.0),
              hintText: 'Confirma tu Contraseña',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrarseBtn() {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: _screenSize.width * .6,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            _focusNode.unfocus();
            if (_value1) {
              print('boton rechazar oprimido ');
              if (_value1 == false) {
                Dialogs.alert(context,
                    description:
                        'Nesesitas aceptar los términos y condiciones');
              } else {
                if (_value1 = true && _pass.text == _passConfirm.text) {
                  UsuarioProvider wsUsuario = new UsuarioProvider();
                  wsUsuario
                      .registroUsuario(
                          Registro.obj.idCliente,
                          Registro.obj.idPromotor,
                          Registro.obj.cliente,
                          _passConfirm.text,
                          (_celular.text),
                          '-',
                          Registro.obj.capital,
                          _correo.text,
                          _rfc.text)
                      .then((obj) async {
                    if (obj.error == 0) {
                      await UsuarioProvider.login(new Usuario(
                          correo: _correo.text, pass: _passConfirm.text));
                      Navigator.pushReplacementNamed(context, '/cliente');
                    } else {
                      print(obj.error);

                      if (obj.mensaje == null) {
                        obj.mensaje = 'Ingrese la informacion';
                      }
                      Dialogs.alert(context, description: obj.mensaje);
                    }
                  });
                } else {
                  Dialogs.alert(context, description: 'las contraseñas no coinciden');
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
          color: Colors.green[700],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Continuar',
                style: TextStyle(
                  //color: Color(0xFFFF960A),
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
          color: Colors.green[700],
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

  Widget _vista() {
    return Container(
      color: pfazul2,
      width: 500.0,
      height: 200.0,
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
      _focusNode = FocusScope.of(context);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus)
        _controller.forward();
      else
        _controller.reverse();
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
         behavior: HitTestBehavior.opaque,
          onTap: () {
            _focusNode.unfocus();
          },
          child: Column(
            children: [
              Stack(
                 alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    color: pfazul2,
                    width: 500.0,
                    height: _animation.value + .0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Crear Cuenta',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
               Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      'Disfruta de los beneficios de tener dinero en un click',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: pfAzul, fontSize: 20.0),
                    ),
                    SizedBox(height: 30.0),
                    _buildRFCTF(),
                    SizedBox(height: 10.0),
                    _buildEmailTF(),
                    SizedBox(height: 10.0),
                    _buildCelularTF(),
                    SizedBox(height: 10.0),
                    _buildPasswordTF(),
                    SizedBox(height: 10.0),
                    _buildPasswordConfirmTF(),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _createChecBox(),
                        Column(
                          children: [
                            Text(
                              'Al continuar Acepto',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.grey[700]),
                            ),
                            InkWell(
                              child: Text(
                                  'Términos y Condiciones y Aviso de privacidad',
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 12.0)),
                              onTap: () {
                                _launchInBrowser(_launchUrl);
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                    _buildRegistrarseBtn(),
                    SizedBox(height: 20.0),
                    _footer(context),
                  ],
                ),
              ),
            ],
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
