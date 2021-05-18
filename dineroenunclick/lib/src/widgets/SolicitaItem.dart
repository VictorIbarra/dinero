import 'package:dineroenunclick/src/models/CreditoModel.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/PromocionProvider.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/utilities/debouncer.dart';
import 'package:dineroenunclick/src/utilities/dialogs.dart';
import 'package:dineroenunclick/src/utilities/metodos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SolicitaItem extends StatefulWidget {
  final Credito credito;
  SolicitaItem({this.credito});

  @override
  _SolicitaItem createState() => _SolicitaItem(credito: credito);
}

class Title extends StatelessWidget {
  final data;
  Title(this.data);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: pfazul2,
        fontSize: 24,
        fontWeight: FontWeight.w900,
        fontFamily: 'Montserrat',
      ),
    );
  }
}

class _SolicitaItem extends State<SolicitaItem> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _debouncer = Debouncer();
  final Credito credito;

  String _pago = '--';
  double _slider;
  double _min = 0;
  int _divisions;

  _SolicitaItem({this.credito});

  @override
  void initState() {
    super.initState();
    _slider = credito.disponible;
    _min = credito.disponible < 1000
        ? credito.disponible < 100
            ? 10
            : 100
        : 1000;
    _divisions = _calculateDivisions(
        credito.disponible < 1000 ? 1 : 1000, credito.disponible);
    _handleCalcularPagoMensual();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.all(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 120.0),
                        width: double.infinity,
                        height: 45.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: pfazul2,
                          border: Border.all(
                              color: pfazul2, width: 3.0), // Set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // Set rounded corner radius
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Disponible',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('  '),
                            Text(
                              credito.index.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 05.0),
                  Text(
                    '\$ ${comma(_slider.toStringAsFixed(0))}',
                    style: TextStyle(
                        color: pfazul2,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 05),
                  Text(
                    'Monto a solicitar',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: 10),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: _ThumbShape(
                    min: _min,
                    max: credito.disponible,
                    thumbHeight: 22,
                    thumbRadius: 15,
                  ),
                  showValueIndicator: ShowValueIndicator.never,
                ),
                child: Slider(
                  value: _slider,
                  min: _min,
                  max: credito.disponible,
                  activeColor: pfazul2,
                  inactiveColor: pfVerde2,
                  onChanged: (val) {
                    setState(() {
                      _slider = val;
                    });
                    _debouncer(() {
                      _handleCalcularPagoMensual();
                    });
                  },
                  divisions: _divisions,
                ),
              ),
              SizedBox(height: 01),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: RaisedButton(
                    elevation: 5,
                    padding: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.green[700],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'en 1 Click',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          ' ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 22.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                      ],
                    ),
                    onPressed: () {
                      Dialogs.showConfirmationDialog(
                        context,
                        nombre: Usuario.usr.nombreCompleto,
                        phone: Usuario.usr.telefono,
                        action: () => _handleSubmit(context),
                      );
                    }),
              ),
              Container(
                padding: EdgeInsets.only(top: 05.0),
                width: double.infinity,
                height: 28.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey[900], width: 1.0), // Set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // Set rounded corner radius
                ),
                // padding: EdgeInsets.all(4),
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Plazo ',
                                  style: TextStyle(
                                      color: Colors.grey[900], fontSize: 15.0),
                                ),
                                Text(
                                  '${credito.plazo} ${credito.frecuencia == 'M' ? 'Meses' : 'Quincenas'}',
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'PAGO ${credito.frecuencia == 'M' ? 'MENSUAL' : 'QUINCENAL'}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[900],
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  comma('\$ $_pago'),
                                  style: TextStyle(
                                    color: pfazul2,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Divider(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Column(
                    //       children: [
                    //         Text(
                    //           'MONTO',
                    //           style: TextStyle(fontSize: 10, color: pffgris2),
                    //         ),
                    //         Text(
                    //           '\$ ${comma(credito.capital.toStringAsFixed(0))}',
                    //           style: TextStyle(
                    //             color: pfazul2,
                    //             fontSize: 18,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //     Column(
                    //       children: [
                    //         Text(
                    //           'PLAZO',
                    //           style: TextStyle(fontSize: 10, color: pffgris2),
                    //         ),
                    //         Text(
                    //           '${credito.plazo} ${credito.frecuencia == 'M' ? 'Meses' : 'Quincenas'}',
                    //           style: TextStyle(
                    //             color: pfazul2,
                    //             fontSize: 18,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //     Column(
                    //       children: [
                    //         Text(
                    //           'PAGO ${credito.frecuencia == 'M' ? 'MENSUAL' : 'QUINCENAL'}',
                    //           style: TextStyle(fontSize: 10, color: pffgris2),
                    //         ),
                    //         Text(
                    //           '\$ ${credito.pago.toStringAsFixed(0)}',
                    //           style: TextStyle(
                    //             color: pfazul2,
                    //             fontSize: 18,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }

  int _calculateDivisions(double montoMin, double montoMax) {
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

  Future<void> _handleCalcularPagoMensual() async {
    final res = await PromocionProvider.calculaMontoMensual(
      frecuencia: credito.frecuencia,
      plazo: credito.plazo,
      taza: credito.tasa,
      monto: credito.saldoCredito + _slider,
    );

    if (res.error != 0)
      setState(() {
        _pago = "0.00";
      });
    else
      setState(() {
        _pago = res.data.pagoErogacion.toStringAsFixed(1);
      });
  }

  Future<void> _handleSubmit(BuildContext context) async {
    Dialogs.showLoadingDialog(context, _keyLoader);

    final valid = await PromocionProvider.subirAplicacionCredito(
        idSolicitud: credito.idSolicutud,
        idProducto: credito.idProducto,
        idSucursal: credito.idSucursal,
        clabe: credito.clabe,
        saldoCredito: credito.saldoCredito + _slider,
        disponible: _slider,
        phoneNumber: Usuario.usr.telefono);
    if (valid) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
        ..pop()
        ..popAndPushNamed('/respuestaCredito');
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    }
  }
}

class _ThumbShape extends RoundSliderThumbShape {
  final double thumbRadius;
  final double thumbHeight;
  final double min;
  final double max;

  const _ThumbShape({
    this.thumbRadius,
    this.thumbHeight,
    this.min,
    this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  String getValue(double value) {
    final val = (min + (max - min) * value);
    return '\$' + comma(val.round().toString());
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double value,
      double textScaleFactor,
      Size sizeWithOverflow}) {
    super.paint(
      context,
      center,
      activationAnimation: activationAnimation,
      enableAnimation: enableAnimation,
      sliderTheme: sliderTheme,
      value: value,
      textScaleFactor: textScaleFactor,
      sizeWithOverflow: sizeWithOverflow,
    );
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: thumbHeight * 3.5,
        height: thumbHeight * 1.1,
      ),
      Radius.circular(thumbRadius),
    );

    final paint = Paint()
      ..color = pfazul2 //Thumb Background Color
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
      style: new TextStyle(
        fontSize: thumbHeight * 0.7,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      text: getValue(value),
    );

    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.save();
    canvas.translate(0, center.dy * -1.2);
    canvas.drawRRect(rRect, paint);
    tp.paint(canvas, textCenter);
  }
}
