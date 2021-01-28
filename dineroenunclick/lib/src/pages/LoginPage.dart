import 'package:dineroenunclick/src/providers/PreferenciasUsuario.dart';
import 'package:dineroenunclick/src/providers/PromocionProvider.dart';
import 'package:dineroenunclick/src/widgets/modals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/UsuarioProvider.dart';
import 'package:dineroenunclick/src/utilities/metodos.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  TextEditingController _codigoController = TextEditingController();
  TextEditingController _correoController = TextEditingController();
  TextEditingController _correo = TextEditingController();
  TextEditingController _pass = TextEditingController();
  String _codigo = "";
  String _correoStr = "";
  final codigoKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  



  /* BIOMETRIC.AUTH */
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized Puto';
  bool _isAuthenticating = false;

  final prefs = new PreferenciasUsuario();
  int _loginType = 1;

  @override
  void initState() { 
    super.initState();

    try{

      _correo.text = Usuario.usr.rfc;

      if(prefs.huella){
        _loginType = 2;
      }
      else{ //CONTRASEÑA
        _loginType = 1;
      }
    }
    catch(Exception){//SI NO PUEDE OBTENER EL NOMBRE DEL USUARIO
      _loginType = 1;
    }    
  }


  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;

    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }


  Future<void> _authenticate(BuildContext context ) async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Escanea tu huella para accesar',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
      print(_authorized);

      if(_authorized == 'Authorized'){
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/cliente');
      }
    });
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }


  UsuarioProvider wsUsuario = new UsuarioProvider();

  _modalCodigoUsuario(BuildContext context) async {
    
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ingresa tu Codigo'),
            content: Form(
              key: codigoKey,
              child: TextFormField(
                textCapitalization: TextCapitalization.characters,
                autofocus: true,
                validator: (value){
                  return 'Codigo Invalido';
                },
                controller: _codigoController,
                decoration: InputDecoration(hintText: "Codigo de 6 caracteres"),
                onChanged: (valor){
                    _codigo = valor;
                    //_codigo = 'UY25P3';
                },
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('GUARDAR'),
                onPressed: () {

                  /*setState(() {
                    _codigo = 'UY25P3';                    
                  });*/

                  

                  if(_codigo.length != 6){
                    codigoKey.currentState.validate();
                  }
                  else{
                    wsUsuario.validaCodigoUsuario(_codigo).then((obj){
                    
                      if(obj.idCliente != null){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/registro');
                      }
                      else{
                        codigoKey.currentState.validate();
                      }

                    });

                  }

                  
                  
                },
              )
            ],
          );
        });
  }

  _modalResetUsuario(BuildContext context, ScaffoldState contextScaffold) async {
    
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Restablece tu contraseña'),
            content: Form(
              key: codigoKey,
              child: TextFormField(
                autofocus: true,
                validator: (value){
                  return 'Codigo Invalido';
                },
                controller: _correoController,
                decoration: InputDecoration(hintText: "Ingresa tu correo"),
                onChanged: (valor){
                    _correoStr = valor;
                    //_codigo = 'UY25P3';
                },
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Restablecer'),
                onPressed: () async{

                  UsuarioProvider.resetPassword(new Usuario(correo: _correoStr)).then((obj){
                    print(obj.mensaje);
                    //_modalResetUsuarioResponse(context, obj);

                    (contextScaffold).showSnackBar(
                      SnackBar(
                        backgroundColor: pfNaranja,
                        content: Text(obj.mensaje),
                    ));
                    
                  });

                  Navigator.pop(context);
                  
                },
              )
            ],
          );
        });
  }

  
  

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Usuario',
          style: kLabelStyle,
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _correo,
            validator: (value){
              if(!validaVacio(value)){
                return 'Ingresa un usuario valido';
              }
              else{
                return null;
              }
            },
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
              hintText: 'RFC ó Correo electrónico',
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
          child: TextFormField(
            validator: (value){
              if(!validaVacio(value)){
                return 'Ingresa tu contraseña';
              }
              else{
                return null;
              }
            },
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
              hintText: 'Ingresa tu contraseña',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildLoginBtn(ScaffoldState contextScaffold) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: _screenSize.width * .6,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async{

          FocusScope.of(context).requestFocus(new FocusNode());

          if(formKey.currentState.validate()){

            Future a = modalLoading(context, 'Validando ...', true);
            
            Usuario usr = new Usuario();
            usr = await UsuarioProvider.login(new Usuario(correo: _correo.text, pass: _pass.text));

            if(usr.clienteId != null){
              //a.whenComplete(action)
              PromocionProvider.cotizacionCliente(usr.clienteId).then((value) => {
                print(value),
                Navigator.pushReplacementNamed(context, '/cliente')
              });
              
            }
            else{
              Navigator.pop(context);
              (contextScaffold).showSnackBar(
                SnackBar(
                  backgroundColor: pfNaranja,
                  content: Text('Datos incorrectos'),
              ));
            }

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

  Widget _buildLoginHuellaBtn(BuildContext bContext, ScaffoldState contextScaffold) {
    final _screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            Icon(Icons.fingerprint, color: pfAzul, size: _screenSize.width/3,),
            SizedBox(height: 10.0),
            Text('Toca para ingresar con tu huella', style: kHintTextStyle),
          ],
        ),

      ),
      onTap:(){
        if(_isAuthenticating){
          _cancelAuthentication();
        }
        else{
          _authenticate(bContext);
        }
      },
    );

  }
  
  Widget _buildRecuperarBtn(ScaffoldState contextScaffold) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      //margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: _screenSize.width * .3,
      height: _screenSize.height * .07,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async{
          _modalResetUsuario(context, contextScaffold);
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
              'Recuperar',
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

  Widget _buildRegistroBtn(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      //margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: _screenSize.width * .3,
      height: _screenSize.height * .07,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async{
          _modalCodigoUsuario(context);
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
              'Aquí',
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

  
  Widget _fragmentLogin(BuildContext context){

    switch(_loginType){
      case 1: //TRADICIONAL
        return _fragLoginTradicional(context);
      break;
      case 2: //BIOMETRICO
        return _fragLoginBiometrico(context);
      break;
      default:
        return _fragLoginTradicional(context);
      break;
    }

  }

  Widget _fragLoginTradicional(BuildContext context){

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
                  
          _buildEmailTF(),
          
          SizedBox(height: 10.0),
          
          _buildPasswordTF(),
          
          _buildLoginBtn(Scaffold.of(context)),
        ],
      ),
    );


     

  }

  Widget _fragLoginBiometrico(BuildContext context){

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50.0),

          Text('Hola, ${Usuario.usr.nombreCompleto.split(' ')[0]} !', style: TextStyle(
             color: pfVerde,
             fontSize: 25.0,
             fontWeight: FontWeight.w900,
             fontFamily: 'Montserrat',
             ),),

          SizedBox(height: 15.0),

          GestureDetector(
            child: Text('Ingresar con contraseña', style: TextStyle(
              color: pfGris,
              decoration: TextDecoration.underline,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
              )),
            onTap: (){
              prefs.huella = false;

              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
              
            },
          ),

          

          SizedBox(height: 30.0),
          
          _buildLoginHuellaBtn(context, Scaffold.of(context)),

        ],
      ),
    );

  }

  Widget _footer(BuildContext context, ScaffoldState contextScaffold){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
       
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Olvidaste tu contraseña?', style: kLabelTinyHeader,),
              _buildRecuperarBtn(contextScaffold)
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: <Widget>[
              Text('Crear una cuenta?', style: kLabelTinyHeader,),
              _buildRegistroBtn(context)
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
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40.0,),
                Text('\$', style: TextStyle(
                    color: Color(0xFF21D702),
                    fontSize: 100.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                  )
                ),

                GestureDetector(
                  onLongPress: (){

                    if(developMode){
                      modalInput(context, null, TextInputType.text, false, prefs.ip, prefs.ip, 'CANCELAR', 'GUARDAR', null, (texto){
                        prefs.ip = texto;
                        print(prefs.ip);
                        setApi();
                        Navigator.pop(context);
                      });
                    }
                    
                  },
                  child:  Text('en 1 click ', style: TextStyle(
                    color: pfAzul,
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                    )
                  ),
                ),
                  
               _fragmentLogin(context),
                
                Expanded(child: SizedBox(),),
                
                _footer(context, Scaffold.of(context)),
                
                SizedBox(height: 25.0,),

              ],
            ),

          )
          
        ),
      ),
      
    );
      
  }
}