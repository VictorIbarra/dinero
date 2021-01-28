import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';

class InformacionPage extends StatefulWidget {
  InformacionPage({Key key}) : super(key: key);

  _InformacionPageState createState() => _InformacionPageState();
}

class _InformacionPageState extends State<InformacionPage> {

  TextEditingController _nombre = TextEditingController();
  TextEditingController _correo = TextEditingController();
  TextEditingController _celular = TextEditingController();

  String nombre = Usuario.usr.nombreCompleto;
  String correo = Usuario.usr.correo;
  String celular = Usuario.usr.telefono;
  


  Widget _buildNombreTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nombre',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            onChanged: (valor){
              //_nombre.text = valor;

            },
            
            keyboardType: TextInputType.text,
            controller: _nombre,
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
              hintText: 'Ingresa tu nombre',
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
              hintText: 'Ingresa tu celular',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuardarBtn() {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      //margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: _screenSize.width * .4,
      height: _screenSize.height * .09,
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
              'Guardar',
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



  Widget _footer(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // _buildGuardarBtn()
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _nombre.text = nombre;
    _correo.text = correo;
    _celular.text = celular;
    return super.initState();
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
            FocusScope.of(context).requestFocus(new FocusNode());
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.arrow_back_ios, ),
          Icon(Icons.arrow_back_ios, ),
        ],
        title: Center(
          child: Text('Mi cuenta', style: TextStyle(
          color: pfGris,
          fontSize: 15.0,
          fontWeight: FontWeight.w900,
          fontFamily: 'Montserrat',
          ),
        ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30.0,),
                        
            _buildNombreTF(),
            
            SizedBox(height: 20.0),

            _buildEmailTF(),

            SizedBox(height: 20.0),
            
            _buildCelularTF(),

            Expanded(child: SizedBox(),),
            
            _footer(context),
            
            SizedBox(height: 25.0,),

          ],
        ),
      ),
    );
    
  }
}