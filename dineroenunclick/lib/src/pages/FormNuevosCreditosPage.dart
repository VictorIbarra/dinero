import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/NuevoCreditoProvider.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/utilities/dialogs.dart';
import 'package:flutter/material.dart';

class FormNuevosCreditos extends StatefulWidget {
  FormNuevosCreditos({Key key}) : super(key: key);

  @override
  _FormNuevosCreditosState createState() => _FormNuevosCreditosState();
}

class _FormNuevosCreditosState extends State<FormNuevosCreditos> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController _nombre = TextEditingController();
  TextEditingController _apellidoPaterno = TextEditingController();
  TextEditingController _correo = TextEditingController();
  TextEditingController _celular = TextEditingController();
  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.view_headline,
                color: pfazul2,
              ),
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, '/hola');
                });
              },
            )
          ],
          title: Center(
            child: Text(
              'Solicita tu Crédito',
              style: TextStyle(
                color: pfazul2,
                fontSize: 19.0,
                fontWeight: FontWeight.w900,
                fontFamily: 'Montserrat',
              ),
            ),
          )),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            reverse: true,
            child: Container(
              padding: EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Te damos la Bienvenida a tu nueva aplicacion para obtener dinero en un click',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: pfAzul,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _builName(),
                  SizedBox(height: 10.0),
                  _buildLastName(),
                  SizedBox(height: 10.0),
                  _buildEmail(),
                  SizedBox(height: 10.0),
                  _buildCelular(),
                  SizedBox(height: 30.0),
                  Text(
                    'Conoce todos los beneficios que te ofrecemos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: pfAzul,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Te brindamos un servicio totalmente personalizado en breve nos pondremos en contacto contigo',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: pfAzul, fontSize: 13.0),
                  ),
                  SizedBox(height: 20.0),
                  _buildRegistrarseBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _builName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            controller: _nombre,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 10.0),
              hintText: 'Tu nombre',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLastName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            controller: _apellidoPaterno,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Tu apellido',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
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

  Widget _buildCelular() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            textInputAction: TextInputAction.done,
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

  Widget _buildRegistrarseBtn() {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: _screenSize.width * .6,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () => _handleSubmit(),
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
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          )),
    );
  }

  Future<void> _handleSubmit() async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    final valid = await NuevoCreditoProvider.submitPrellenado(
      Usuario.usr.idUsuarioCliente,
      _nombre.text,
      _apellidoPaterno.text,
      _correo.text,
      _celular.text,
    );
    if (valid)
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .popAndPushNamed('/respuestaFormulario');
    else
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }
}
