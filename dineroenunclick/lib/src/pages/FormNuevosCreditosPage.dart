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
              'Solicita tu Credito',
              style: TextStyle(
                color: pfazul2,
                fontSize: 19.0,
                fontWeight: FontWeight.w900,
                fontFamily: 'Montserrat',
              ),
            ),
          )
          ),
      body: GestureDetector(
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
                  'Bienvenid@, envíanos tus datos para regresarte una llamada  en menos de 15 minutos y ofrecerte un credito a tu medida',
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
                SizedBox(height: 10.0),
                _buildRegistrarseBtn(),
              ],
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
        Text(
          'Nombre',
          style: kLabelStyle,
        ),
        SizedBox(height: 3.0),
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
              hintText: 'Ingresa tu Nombre',
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
        Text(
          'Apellido Paterno',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
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
              hintText: 'Ingresa tu Apellido Paterno',
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
        Text(
          'Correo electronico',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
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
              hintText: 'Ingresa tu correo',
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
        Text(
          'Celular',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            textInputAction: TextInputAction.done,
           keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
            controller: _celular,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: 'Ingresa tu celular',
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
          color: pfVerde,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enviar',
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
