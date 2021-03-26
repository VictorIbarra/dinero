import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/pages/AyudaPage.dart';
import 'package:dineroenunclick/src/pages/ChangeNipPage.dart';
import 'package:dineroenunclick/src/pages/ChangePasswordPage.dart';
import 'package:dineroenunclick/src/pages/ClientePage.dart';
import 'package:dineroenunclick/src/pages/CreditosPage.dart';
import 'package:dineroenunclick/src/pages/InformacionPage.dart';
import 'package:dineroenunclick/src/pages/PromocionPage.dart';
import 'package:dineroenunclick/src/pages/RegistroNewPage.dart';
import 'package:dineroenunclick/src/pages/RegistroPage.dart';
import 'package:dineroenunclick/src/pages/SeguridadPage.dart';
import 'package:dineroenunclick/src/pages/TerminosPage.dart';
import 'package:dineroenunclick/src/pages/respuestaCredito.dart';
import 'package:dineroenunclick/src/providers/PreferenciasUsuario.dart';
import 'package:dineroenunclick/src/providers/db_provider.dart';
import 'package:dineroenunclick/src/providers/push_notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/pages/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotification();
    pushProvider.mensajesStream.listen((data) {
      // print('argumento desde main: $argumento');
      // navigatorKey.currentState.pushNamed('nombre page',arguments: data);
    });
  }

  String _mainRoute = '/';

  Future<List<String>> _getUser() async {
    await DBProvider.db.selectUsuario();

    try {
      print('Currect User: $_mainRoute');
      print('Currect User: ${Usuario.idCliente}');
      print('Currect CLiente: ${Usuario.usr.clienteId}');
      print('Currect Promotor: ${Usuario.usr.promotorId}');
      print('Currect Nombre: ${Usuario.usr.nombreCompleto}');
      print('Currect RFC: ${Usuario.usr.rfc}');
      print('Currect Correo: ${Usuario.usr.correo}');
      print('Currect Telefono: ${Usuario.usr.telefono}');
      print('Currect Linea: ${Usuario.usr.lineaCreditoMax}');
      print('Currect ClavePin: ${Usuario.usr.claveRegistroPiN}');
      print('Currect Clabe: ${Usuario.usr.clabe}');
    } catch (Exception) {
      print('ERROR PRINT');
    }

    if (Usuario.idCliente != 0) {
      _mainRoute = '/login';
    } else {
      _mainRoute = '/login';
    }

    List<String> list = new List<String>();
    list.add(_mainRoute);

    return list;
  }

  _drawMainPage(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Prestamo Feliz',
      initialRoute: _mainRoute,
      routes: {
        '/login': (context) => LoginPage(),
        '/cliente': (context) => ClientePage(),
        '/misCreditos': (context) => CreditosPage(),
        '/registro': (context) => RegistroPage(),
        '/informacion': (context) => InformacionPage(),
        '/seguridad': (context) => SeguridadPage(),
        '/changePassword': (context) => ChangePasswordPage(),
        '/changeNIP': (context) => ChangeNipPage(),
        '/ayuda': (context) => AyudaPage(),
        '/promocionDetalle': (context) => DetallePage(),
        '/terminos': (context) => TerminosPage(),
        '/respuestaCredito': (context) => RespuestaCreditoPage(),
        '/registroNewPage': (context) => RegistroNewPage(),
      },
      theme: ThemeData(
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,
          secondaryHeaderColor: Colors.grey,
          iconTheme: IconThemeData(color: Colors.white)),
      home: LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUser(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _drawMainPage(context);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
