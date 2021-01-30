import 'dart:collection';
import 'dart:math';

import 'package:dineroenunclick/src/models/PromocionModel.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/CreditoProvider.dart';
import 'package:dineroenunclick/src/widgets/modals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/utilities/metodos.dart';

class PromocionPage extends StatefulWidget {
  PromocionPage({Key key}) : super(key: key);

  _PromocionPageState createState() => _PromocionPageState();
}

class _PromocionPageState extends State<PromocionPage>
    with AutomaticKeepAliveClientMixin<PromocionPage> {
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

  // _modalInfoAmpliacion(BuildContext context) async {
  //   modalConfirmacion(
  //       context, 'Confirmación !', 'Esta seguro de generar este crédito?', () {
  //     productoId = _getProductoIdByPlazo(
  //         plazosVal.round(), prom.productos, prom.frecuencia);

  //     //Navigator.pop(context);
  //     Future a = modalLoading(context, 'Generando credito ...', true);

  //     CreditoProvider.altaCreditoPromocion(Usuario.usr.clienteId,
  //             prom.promocionId, productoId, monto, erogacionFinal)
  //         .then((obj) {
  //       Navigator.pop(context);
  //       Navigator.pop(context);
  //       Navigator.pushReplacementNamed(context, '/misCreditos');
  //     });
  //   });
  // }

  _modalAceptarCreditoUsuario(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Introduce tu teléfono'),
            content: Form(
              // key: codigoKey,
              child: TextFormField(
                textCapitalization: TextCapitalization.characters,
                autofocus: true,
                validator: (value) {
                  return '10 digitos';
                },
                // controller: _codigoController,
                decoration: InputDecoration(hintText: "10 digitos"),
                onChanged: (valor) {
                  // _codigo = valor;
                  //_codigo = 'UY25P3';
                },
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('ACEPTAR'),
                onPressed: () {
                  /*setState(() {
                    _codigo = 'UY25P3';                    
                  });*/

                  // if (_codigo.length != 6) {
                  //   codigoKey.currentState.validate();
                  // } else {
                  //   wsUsuario.validaCodigoUsuario(_codigo).then((obj) {
                  //     if (obj.idCliente != null) {
                  //       Navigator.pop(context);
                  //       Navigator.pushNamed(context, '/registro');
                  //     } else {
                  //       codigoKey.currentState.validate();
                  //     }
                  //   });
                  // }
                },
              )
            ],
          );
        });
  }

  Widget _buildContinuarBtn(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: _screenSize.width * .6,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () async {
            // _modalInfoAmpliacion(context);
            _modalAceptarCreditoUsuario(context);
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: pfAzul,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'en 1 Click',
                style: TextStyle(
                  //color: Color(0xFFFF960A),
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(Icons.check, color: Colors.white)
            ],
          )),
    );
  }

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
  Widget build(BuildContext context) {
    final Promocion promocion = ModalRoute.of(context).settings.arguments;

    setState(() {
      //monto = promocion.monto;
    });

    super.build(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          //automaticallyImplyLeading: false,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),

              Text('Disponible', style: kLabelHeader),

              SizedBox(
                height: 30.0,
              ),

              Text('Monto', style: kLabelMiniHeader),
              Text(
                '\$${comma(monto.round().toString())}',
                style: kLabelHeader,
              ),

              Slider.adaptive(
                value: monto,
                min: 1000,
                max: promocion.monto,
                onChanged: (valor) {
                  setState(() {
                    monto = valor;
                  });
                },
                activeColor: pfAzul,
                divisions: divisiones,
              ),

              SizedBox(
                height: 30.0,
              ),

              Text(
                  'Plazo en ' +
                      (prom.frecuencia == 'M' ? 'mensualidades' : 'quincenas'),
                  style: kLabelMiniHeader),
              Text(
                '${plazosVal.round()}',
                style: kLabelHeader,
              ),

              // Slider.adaptive(
              //   value: plazosValSlider,
              //   min: plazosMin,
              //   max: plazosMax,
              //   onChanged: (valor){
              //     setState(() {
              //       plazosValSlider = valor;
              //       //print(valor);
              //       int step = (valor/((((plazosMax-plazosMin)-1)/plazosDiv))).round();
              //       //print(step);
              //       //print(rangosSlider[step-1]);
              //       plazosVal = double.parse(rangosSlider[step-1].toString());
              //     });
              //   },
              //   activeColor: pfAzul,
              //   divisions: plazosDiv,
              // ),

              SizedBox(
                height: 60,
              ),

              Text(
                '\$${comma((_calPago(monto, plazosVal, prom.tasa, 0)).round().toString())}',
                style: kLabelHeader,
              ),
              Text('Pago ' + (prom.frecuencia == 'M' ? 'Mensual' : 'Quincenal'),
                  style: kLabelMiniHeader),

              //Expanded(child: SizedBox(),),

              SizedBox(
                height: 30,
              ),

              _buildContinuarBtn(context),
            ],
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
