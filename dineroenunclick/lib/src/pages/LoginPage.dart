import 'package:dineroenunclick/src/providers/PreferenciasUsuario.dart';
import 'package:dineroenunclick/src/providers/PromocionProvider.dart';
import 'package:dineroenunclick/src/widgets/modals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/UsuarioProvider.dart';
import 'package:dineroenunclick/src/utilities/metodos.dart';
import 'package:get_version/get_version.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _codigoController = TextEditingController();
  TextEditingController _correoController = TextEditingController();
  TextEditingController _correo = TextEditingController();
  TextEditingController _pass = TextEditingController();
  String _codigo = "";
  String _correoStr = "";
  final codigoKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  final prefs = new PreferenciasUsuario();
  int _loginType = 1;
  String _projectVersion = '';
  bool _validate = false;
  bool _obscureText = true;

  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  initPlatformState() async {
    String projectVersion;
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    if (!mounted) return;

    setState(() {
      _projectVersion = projectVersion;
    });
  }

  @override
  void initState() {
    super.initState();

    initPlatformState();

    try {
      if (prefs.huella) {
        _loginType = 2;
      } else {
        //CONTRASEÑA
        _loginType = 1;
      }
    } catch (Exception) {
      _loginType = 1;
    }
  }

  UsuarioProvider wsUsuario = new UsuarioProvider();

  _modalCodigoUsuario(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Si ya eres cliente pide tu código',
              style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            content: Form(
              key: codigoKey,
              child: TextFormField(
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.characters,
                autofocus: true,
                validator: (value) {
                  return 'Codigo Invalido';
                },
                controller: _codigoController,
                decoration: InputDecoration(hintText: "Código de 6 caracteres"),
                onChanged: (valor) {
                  _codigo = valor;
                },
              ),
            ),
            actions: <Widget>[
              Column(
                children: [
                  Row(
                     mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                         width: MediaQuery.of(context).size.width * 0.30,
                        child: RaisedButton(
                          color: Colors.green[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            if (_codigo.length != 6) {
                              codigoKey.currentState.validate();
                            } else {
                              wsUsuario.validaCodigoUsuario(_codigo).then((obj) {
                                if (obj.idCliente != null) {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/registro');
                                } else {
                                  codigoKey.currentState.validate();
                                }
                              });
                            }
                          },
                          child: Text(
                            "Continuar",
                            style: (TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
                  Container(
                width: MediaQuery.of(context).size.width * 0.22,
              ),
                    ],
                  ),
                  FlatButton(
                    child: Text(
                      'No soy cliente                     ',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/registroNewPage');
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  _modalResetUsuario(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Restablece tu contraseña',
                style: TextStyle(color: Colors.grey[600])),
            content: Form(
              key: codigoKey,
              child: TextFormField(
                textAlign: TextAlign.center,
                autofocus: true,
                validator: (value) {
                  return 'Ingresa tu correo';
                },
                controller: _correoController,
                decoration: InputDecoration(hintText: "Ingresa tu correo"),
                onChanged: (valor) {
                  _correoStr = valor;
                  //_codigo = 'UY25P3';
                },
              ),
            ),
            actions: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('                '),
                  RaisedButton(
                    color: Colors.green[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      
                      if (_correoStr.length >= 6) {
                         UsuarioProvider.resetPassword(
                                new Usuario(correo: _correoStr))
                            .then((obj) {
                          print(obj.mensaje);
                        }
                        );
                       Navigator.pop(context);
                      } else {
                           codigoKey.currentState.validate();
                      }
                    },
                    child: Text(
                      "       Restablecer     ",
                      style: (TextStyle(color: Colors.white)),
                    ),
                  ),
                  Text('                ')
                ],
              ),
            ],
          );
        });
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            controller: _correo,
            validator: (value) {
              if (value.isEmpty) {
                return 'Ingresa un usuario valido';
              } else {
                return null;
              }
            },
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0, top: 15.0),
              fillColor: Colors.white,
              filled: true,
              hintText: 'Correo electrónico',
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
          child: TextFormField(
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value.isEmpty) {
                return 'Ingresa contraseña';
              } else {
                return null;
              }
            },
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
              hintText: ' Ingresa tu Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _togglePasswordStatus,
                color: Colors.green,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 18.0, top: 22.0),
              fillColor: Colors.white,
              filled: true,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),

        //   Container(
        //   padding: EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
        //   child: Form(
        //     child: Column(children: <Widget>[
        //       TextFormField(
        //         decoration: InputDecoration(
        //           hintText: 'Password',
        //           suffixIcon:  IconButton(
        //             icon:Icon(_obscureText ? Icons.visibility:Icons.visibility_off,),
        //              onPressed: _togglePasswordStatus,
        //              color: Colors.green,
        //              ),
        //         ),
        //         validator: (val){
        //           return
        //           val.length < 6 ? 'Enter A Password Longer Than 6 Charchters' :null;
        //         },
        //         obscureText: _obscureText,
        //         onChanged: (val){
        //           setState(() {
        //             // password = val.trim();
        //           });
        //         },
        //       ),
        //   ],),),
        // )
      ],
    );
  }

  Widget _buildLoginBtn(ScaffoldState contextScaffold) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: _screenSize.width * .6,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            FocusScope.of(context).requestFocus(new FocusNode());

            if (formKey.currentState.validate()) {
              Future a = modalLoading(context, 'Validando ...', true);

              Usuario usr = new Usuario();
              usr = await UsuarioProvider.login(
                  new Usuario(correo: _correo.text, pass: _pass.text));

              if (usr.clienteId != null) {
                PromocionProvider.cotizacionCliente(usr.clienteId).then(
                    (value) => {
                          print(value),
                          Navigator.pushReplacementNamed(context, '/cliente')
                        });
              } else {
                Navigator.pop(context);
                (contextScaffold).showSnackBar(SnackBar(
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
          color: Colors.green[700],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                ' Continuar ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 26.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            ],
          )),
    );
  }

  Widget _fragmentLogin(BuildContext context) {
    switch (_loginType) {
      case 1: //TRADICIONAL
        return _fragLoginTradicional(context);
        break;
      default:
        return _fragLoginTradicional(context);
        break;
    }
  }

  Widget _fragLoginTradicional(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30.0),
          _buildEmailTF(),
          SizedBox(height: 10.0),
          _buildPasswordTF(),
          SizedBox(height: 10.0),
          InkWell(
            child: Text(
              'Olvidaste tu contraseña',
              style: TextStyle(color: Colors.grey[700], fontSize: 16.0),
            ),
            onTap: () {
              _modalResetUsuario((context));
            },
          ),
          SizedBox(height: 50.0),
          Container(
              margin: EdgeInsets.only(left: 70.0),
              child: _buildLoginBtn(Scaffold.of(context))),
        ],
      ),
    );
  }

  Widget _footer(BuildContext context, ScaffoldState contextScaffold) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            children: <Widget>[
              Text('¿Áun no tienes cuenta?',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(height: 10.0),
              InkWell(
                child: Text(
                  'CREAR CUENTA',
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
                onTap: () {
                  _modalCodigoUsuario(context);
                },
              ),
              SizedBox(height: 10.0),
              //  SizedBox(height: 200.0),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              Color.fromRGBO(6, 6, 159, 1),
              Color.fromRGBO(6, 6, 159, 1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Builder(
            builder: (context) => Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                      ),
                      Image.asset(
                        'assets/nuevoLogo.png',
                        height: 180,
                        width: 180,
                      ),
                      _fragmentLogin(context),
                      SizedBox(
                        //probar estaba en 60 y 25
                        height: 20.0,
                      ),
                      _footer(context, Scaffold.of(context)),
                      SizedBox(
                        height: 10.0,
                      ),
                      //versionamiento
                      Text(
                        "v $_projectVersion",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
