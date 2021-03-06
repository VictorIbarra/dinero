import 'package:dineroenunclick/src/models/RegistroModel.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/UsuarioProvider.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:flutter/material.dart';


class RegistroPage extends StatefulWidget {
  RegistroPage({Key key}) : super(key: key);
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

  TextEditingController _correo = TextEditingController();
  TextEditingController _rfc = TextEditingController();
  TextEditingController _celular = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _passConfirm = TextEditingController();

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
              /*prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),*/
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
              /*prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),*/
              hintText: 'Ingresa tu email',
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
        Text(
          'Numero celular',
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
              /*prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),*/
              hintText: Registro.obj.celular.toString(),
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
              /*prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),*/
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
              /*prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),*/
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
        onPressed: () async{

          FocusScope.of(context).requestFocus(new FocusNode());

          if(_pass.text == _passConfirm.text){

            UsuarioProvider wsUsuario = new UsuarioProvider();
            wsUsuario.registroUsuario(Registro.obj.idCliente, Registro.obj.idPromotor, Registro.obj.cliente, _passConfirm.text, (_celular.text), '-', Registro.obj.capital, _correo.text, _rfc.text).then((obj) async{
              
              if(obj.error == 0){
                await UsuarioProvider.login(new Usuario(correo: _correo.text, pass: _passConfirm.text));
                Navigator.pushReplacementNamed(context, '/cliente');
              }
              else{
                print(obj.mensaje);

                if(obj.mensaje == null){
                  obj.mensaje = 'Ingrese la informacion';
                }

                (contextScaffold).showSnackBar(
                  SnackBar(
                    backgroundColor: pfNaranja,
                    content: Text(obj.mensaje),
                ));
                
              }              

            });

          }
          else{
            (contextScaffold).showSnackBar(
                SnackBar(
                  backgroundColor: pfNaranja,
                  content: Text('Las Contraseñas no coinciden.'),
              ));
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
                //color: Color(0xFFFF960A),
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),

            Icon(Icons.keyboard_arrow_right, color: Colors.white)

          ],
        )
        
      ),
    );
  }

  Widget _buildRegresarBtn() {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      //margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: _screenSize.width * .3,
      height: _screenSize.height * .07,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async{
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
        )
        
      ),
    );
  }

  Widget _footer(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildRegresarBtn()
            ],
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Registro', style: TextStyle(
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
              SizedBox(height: 20.0,),
              
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
              
              _buildRegistrarseBtn(Scaffold.of(context)),
              
              Expanded(child: SizedBox(),),
              
              _footer(context),
              
              SizedBox(height: 25.0,),

            ],
          ),
        ),
      ),
      
    );
      
  }
}