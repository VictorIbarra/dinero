import 'dart:collection';
import 'dart:math';

import 'package:dineroenunclick/src/models/CreditoModel.dart';
import 'package:dineroenunclick/src/models/PromocionModel.dart';
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
  double monto = 0;
  int divisions = 0;
  Credito credito;
  String phoneNumber = Usuario.usr.telefono;

  int _calDivisiones(double montoMin, double montoMax) {
    int factor = 500;
    int montoReal = ((montoMax - montoMin).round());
    int steps = 10;
    if (montoMax < 1000) {
      factor = 100;
    } else if (montoMax < 30000) {
      factor = 500;
    } else if (montoMax >= 30000 && montoMax < 50000) {
      factor = 1000;
    } else if (montoMax >= 50000 && montoMax < 100000) {
      factor = 1000;
    } else if (montoMax >= 100000) {
      factor = 1000;
    }
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

  @override
  Widget build(BuildContext context) {
    credito = ModalRoute.of(context).settings.arguments;
    double min = credito.disponible < 1000 ? 100 : 1000;
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
                  monto = val;
                });
              },
              activeColor: pfAzul,
              divisions: divisions,
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
            Text(
              '\$${comma(credito.pago.round().toString())}',
              style: kLabelHeader,
            ),
            Text(
              'Pago ${credito.frecuencia == 'M' ? 'Mensual' : 'Quincenal'}',
              style: kLabelMiniHeader,
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
}

/// ESTA CLASE ERA LA ANTERIORMENET UTILIZADA PARA CALCULAT Y MOSTRAR
/// AQUI SE ENCUENTRA UN EJEMPLO DEL METODO UTILIZADO PARA CALCULAR EL PAGO
class _PromocionPageState extends State with AutomaticKeepAliveClientMixin {
  final codigoKey = GlobalKey<FormState>();
  double mensual = 3000 / 24;
  double monto = 3000;
  double erogacionFinal = 0;
  int productoId = 0;
  double montoIni = 1000;

  int divisiones = 10;

  int plazosDiv = 6;
  double plazosMin = 8;
  double plazosMax = 8;
  double plazosVal = 12;
  double plazosValSlider = 12;
  HashMap plazosRangos = new HashMap<dynamic, dynamic>();

  List<int> rangosSlider = new List<int>();

  Promocion prom = new Promocion();

  int _getProductoIdByPlazo(int plazo, String productos, String frec) {
    List<String> plazos = productos.split('|');
    int prodId = 0;

    plazos.forEach((prod) {
      var obj = prod.trim().split(',');

      if (obj[0] == frec &&
          int.parse(obj[1]) == plazo &&
          double.parse(obj[2]) == prom.tasa) {
        prodId = int.parse(obj[3]);
        return prodId;
      }
    });

    return prodId;
  }

  int _calPago(double capital, double pagos, double tasa, int frecAnual) {
    if (prom.frecuencia == 'M') {
      frecAnual = 12;
    }
    if (prom.frecuencia == 'Q') {
      frecAnual = 24;
    }

    plazosRangos.forEach((k, v) {
      if (k == pagos) {
        tasa = v;
      }
    });

    double factorTasa = tasa / 100;
    double fTasaFrec = factorTasa / frecAnual;
    double conIva = fTasaFrec * 1.16;
    double pagoBase = conIva * capital;

    double pagoDiff = 1 - (pow((1 + conIva), (pagos * -1)));
    double erogacion = pagoBase / pagoDiff;

    erogacionFinal = int.parse(erogacion.toString().split('.')[0]) * 1.0;

    return erogacionFinal.round();
  }

  int _calDivisiones(double montoMin, double montoMax) {
    int factor = 500;
    int montoReal = ((montoMax - montoMin).round());
    int steps = 10;

    if (montoMax < 30000) {
      factor = 500;
    } else if (montoMax >= 30000 && montoMax < 50000) {
      factor = 1000;
    } else if (montoMax >= 50000 && montoMax < 100000) {
      factor = 1000;
    } else if (montoMax >= 100000) {
      factor = 1000;
    }

    steps = (montoReal / factor).round();

    return steps;
  }

  HashMap _setPlazos(String productos, String frec) {
    //productos = 'Q,6,113.7931034|  Q,8,110.0689655|  Q,10,106.4482759|  Q,12,102.7241379|  Q,14,99.0000000|  Q,16,95.2758621|  Q,18,91.6551724|  Q,20,87.9310345|';

    List<String> plazos = productos.split('|');
    HashMap rangos = new HashMap<dynamic, dynamic>();

    int first = 0;
    int last = 0;
    int steps = 1;

    int pagos = 0;
    double tasa = 0;
    int prodId = 0;

    plazos.forEach((prod) {
      var obj = prod.trim().split(',');

      if (obj[0] == frec && double.parse(obj[2]) == prom.tasa) {
        pagos = int.parse(obj[1]);
        tasa = double.parse(obj[2]);
        prodId = int.parse(obj[3]);
        if (first == 0) {
          first = pagos;
        }

        rangos.addAll({pagos: tasa});
      }
    });

    rangos.forEach((key, value) {
      rangosSlider.add(key);
    });

    rangosSlider.sort((a, b) {
      return a.compareTo(b);
    });

    print(rangosSlider);

    last = pagos;

    steps = (rangos.length - 1); //((last - first)/(rangos.length-1)).round();

    plazosDiv = steps;
    plazosMin = first * 1.0;
    plazosMax = last * 1.0;
    plazosVal = plazosMax;
    plazosValSlider = plazosMax;

    setState(() {});

    return rangos;
  }

  @override
  void initState() {
    prom = Promocion.selPROM;

    monto = prom.monto;

    divisiones = _calDivisiones(1000, monto);

    print(prom.productos);

    plazosRangos = _setPlazos(prom.productos, prom.frecuencia);

    super.initState();
  }

  @override
  bool get wantKeepAlive => true;
}
