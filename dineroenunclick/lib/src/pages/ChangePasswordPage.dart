import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/UsuarioProvider.dart';
import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key key}) : super(key: key);

  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  TextEditingController _pass = TextEditingController();
  TextEditingController _passConfirm = TextEditingController();

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

  Widget _buildGuardarBtn(ScaffoldState contextScaffold) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      //margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: _screenSize.width * .4,
      height: _screenSize.height * .09,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async{
          FocusScope.of(context).requestFocus(new FocusNode());

          print(Usuario.usr.clienteId);

          if(_pass.text == _passConfirm.text && _pass.text != ''){
            UsuarioProvider.resetNIP(new Usuario(clienteId: Usuario.usr.clienteId, pass: _passConfirm.text)).then((obj){
              print(obj.mensaje);
              if(obj.error == 0){
                (contextScaffold).showSnackBar(
                  SnackBar(
                    backgroundColor: pfVerde,
                    content: Text(obj.mensaje),
                ));
                
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
                    content: Text('No coincide la contraseña'),
                ));
          }

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
              'Cambiar',
              style: TextStyle(
                //color: Color(0xFFFF960A),
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            )

          ],
        )
        
      ),
    );
  }

  Widget _footer(ScaffoldState contextScaffold){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildGuardarBtn(contextScaffold)
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
        //automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: pfVerde,),
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
          child: Text('Cambio de Contraseña', style: TextStyle(
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
              SizedBox(height: 30.0,),

              _buildPasswordTF(),

              SizedBox(height: 20.0),
              
              _buildPasswordConfirmTF(),

              //Expanded(child: SizedBox(),),
              SizedBox(height: 20.0),
              
              _footer(Scaffold.of(context)),
              
              SizedBox(height: 25.0,),

            ],
          ),
        ),
      ),
      
    );
  }
}