import 'package:dineroenunclick/src/models/CreditoModel.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/PromocionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/utilities/metodos.dart';

class DetallePage extends StatefulWidget {
  DetallePage({Key key}) : super(key: key);

  _DetallePageState createState() => _DetallePageState();
}

class _DetallePageState extends State<DetallePage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<State> _calcularLoadingKey = new GlobalKey<State>();

  double monto = 0;
  int divisions = 0;
  Credito credito;
  String phoneNumber = Usuario.usr.telefono;
  String pagoMensual = '--';

  int _calDivisiones(double montoMin, double montoMax) {
    int factor = 500;
    int montoReal = ((montoMax - montoMin).round());
    int steps = 10;
    if (montoMax < 100)
      factor = 10;
    else if (montoMax < 1000)
      factor = 100;
    else if (montoMax < 30000)
      factor = 100;
    else
      factor = 1000;

    steps = (montoReal / factor).round();
    return steps;
  }

  Future<void> _handleSubmit(BuildContext context, String phone) async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    final valid = await PromocionProvider.subirAplicacionCredito(
        idSolicitud: credito.idSolicutud,
        idProducto: credito.idProducto,
        idSucursal: credito.idSucursal,
        clabe: credito.clabe,
        saldoCredito: credito.saldoCredito + monto,
        disponible: monto,
        phoneNumber: phone);
    if (valid) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
        ..pop()
        ..pop()
        ..popAndPushNamed('/respuestaCredito');
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
        ..pop()
        ..pop();
    }
  }

  Future<void> _handleCalcularPagoMensual(BuildContext context) async {
    Dialogs.showLoadingDialog(context, _calcularLoadingKey);
    final res = await PromocionProvider.calculaMontoMensual(
        frecuencia: credito.frecuencia,
        plazo: credito.plazo,
        taza: credito.tasa,
        monto: credito.saldoCredito + monto);
    Navigator.of(_calcularLoadingKey.currentContext, rootNavigator: true).pop();
    if (res.error != 0) {
      Dialogs.showErrorDialog(context, res.message);
      setState(() {
        pagoMensual = "--";
      });
    } else {
      setState(() {
        pagoMensual = res.data.pagoErogacion.toStringAsFixed(1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    credito = ModalRoute.of(context).settings.arguments;
    double min = credito.disponible < 1000
        ? credito.disponible < 100
            ? 10
            : 100
        : 1000;
    divisions = _calDivisiones(
        credito.disponible < 1000 ? 1 : 1000, credito.disponible);
    if (min > monto) {
      monto = credito.disponible;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: pfAzul,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Icon(
            Icons.arrow_back_ios,
          ),
          Icon(
            Icons.arrow_back_ios,
          ),
        ],
        title: Center(
          child: Text(
            'Solicita',
            style: TextStyle(
              color: pfAzul,
              fontSize: 19.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Disponible', style: kLabelHeader),
            SizedBox(height: 30),
            Text(
              'Monto',
              style: kLabelMiniHeader,
            ),
            Text(
              '\$${comma(monto.toStringAsFixed(1))}',
              style: kLabelHeader,
            ),
            Slider.adaptive(
              value: monto,
              min: min,
              max: credito.disponible,
              onChanged: (val) {
                setState(() {
                  pagoMensual = "--";
                  monto = val;
                });
              },
              activeColor: pfAzul,
              divisions: divisions,
            ),
            SizedBox(height: 30),
            Text(
              'Monto Total',
              style: kLabelMiniHeader,
            ),
            Text(
              '${credito.capital}',
              style: kLabelHeader,
            ),
            SizedBox(height: 30),
            Text(
              'Plazo en ${credito.frecuencia == 'M' ? 'mensualidades' : 'quincenas'}',
              style: kLabelMiniHeader,
            ),
            Text(
              '${credito.plazo}',
              style: kLabelHeader,
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 90.0, right: 90.0),
              child: RaisedButton(
                elevation: 5.0,
                onPressed: () {
                  _handleCalcularPagoMensual(context);
                },
                padding: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Calcular pago mensual',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Pago ${credito.frecuencia == 'M' ? 'Mensual' : 'Quincenal'}',
              style: kLabelMiniHeader,
            ),
            Text(
              '\$${comma(pagoMensual)}',
              style: kLabelHeader,
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              width: MediaQuery.of(context).size.width * .6,
              child: RaisedButton(
                elevation: 5.0,
                onPressed: () {
                  Dialogs.showConfirmationDialog(context,
                      action: () => _handleSubmit(context, phoneNumber),
                      phoneNumber: phoneNumber);
                },
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: pfAzul,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'en 1 Click',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              key: key,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Por favor espere...')
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  static Future<void> showConfirmationDialog(BuildContext context,
      {String phoneNumber, Function action}) async {
    final _formKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            title: Text('Introduce tu teléfono'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autofocus: true,
                validator: (val) {
                  if (val.isEmpty || val.length != 10) return '10 digitos';
                  return null;
                },
                decoration: InputDecoration(hintText: '10 digitos'),
                onChanged: (val) => phoneNumber = val,
                initialValue: phoneNumber,
              ),
            ),
            actions: [
              FlatButton(
                  child: Text('ACEPTAR'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      action();
                    }
                  })
            ],
          );
        });
  }

  static Future<void> showErrorDialog(
      BuildContext context, String content) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            title: Text('Error'),
            content: Text(content),
          );
        });
  }
}
