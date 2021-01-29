import 'package:dineroenunclick/src/models/CreditoModel.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/CreditoProvider.dart';
import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/utilities/metodos.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';

class CreditosPage extends StatefulWidget {
  CreditosPage({Key key}) : super(key: key);

  _CreditosPageState createState() => _CreditosPageState();
}

//codigo de el contorno de la caja
BoxDecoration myBoxDecoration(Color color) {
  return BoxDecoration(
    border: Border.all(width: 1.0, color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  );
}

//colores textos
TextStyle _textStyle(String tipo, Color color) {
  TextStyle ts = TextStyle();

  switch (tipo) {
    case 'hBold':
      ts = TextStyle(
        color: color,
        fontSize: 24.0,
        fontWeight: FontWeight.w900,
        fontFamily: 'Montserrat',
      );
      break;
    case 'hLight':
      ts = TextStyle(
        color: color,
        fontSize: 12.0,
        fontFamily: 'Montserrat',
      );
      break;
    case 'sBold':
      ts = TextStyle(
        color: color,
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
        fontFamily: 'Montserrat',
      );
      break;
  }

  return ts;
}

Widget _itemCredito(BuildContext context, Credito item) {
  final _screenSize = MediaQuery.of(context).size;
  final marginTop = 5.0;
  final marginLeft = 10.0;

  double montoCredito = item.capital;
  double montoPendiente = item.saldo;
  double montoPago = item.erogacion;
  String fecPago = item.fchRecibo.toString();
  int pagosRealizados = item.pagados;
  int pagosTotales = item.pagos;
  // String clabe = item.frecuencia;

  List<Widget> textosL = new List<Widget>();
  List<Widget> textosR = new List<Widget>();

  textosL.add(Container(
    margin: EdgeInsets.only(left: marginLeft),
    child: Column(
      children: [
        Text('Crédito', style: _textStyle('hBold', pfAzul)),
        Text('\$${comma(montoCredito.round().toString())}',
            style: TextStyle(color: Colors.blue[900], fontSize: 20.0)),
      ],
    ),
  ));
  textosL.add(Container(
    margin: EdgeInsets.only(left: marginLeft),
    child: Text(
      '24 meses',
      style: TextStyle(color: Colors.black, fontSize: 15.0),
    ),
  ));
  textosL.add(Container(
      margin: EdgeInsets.only(left: marginLeft),
      child: Column(
        children: <Widget>[
          Text(
            'Monto pago ',
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
          Text(
            '\$${comma(montoPago.round().toString())}',
            style: TextStyle(fontSize: 15.0),
          ),
        ],
      )));

  textosR.add(Container(
    margin: EdgeInsets.only(right: marginLeft),
    child: Column(
      children: [
        Text('Disponible', style: _textStyle('hBold', pfAzul)),
        Text('\$${comma(montoPago.round().toString())}',
            style: TextStyle(color: Colors.blue[900], fontSize: 20.0)),
        //espacios
        Text(''),
        Text(''),
        Text(''),
      ],
    ),
  ));

  // textosR.add(Container(
  //     margin: EdgeInsets.only(right: marginLeft),
  //     child: Row(
  //       children: <Widget>[
  //         Text('Monto de Pago', style: _textStyle('hLight', pfNaranja)),
  //       ],
  //     )));

  // textosR.add(Container(
  //     margin: EdgeInsets.only(right: marginLeft),
  //     child: Row(
  //       children: <Widget>[
  //         Text('$pagosRealizados', style: _textStyle('sBold', pfNaranja)),
  //         Text(' de $pagosTotales', style: _textStyle('hLight', Colors.grey)),
  //       ],
  //     )));

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: marginTop),
        width: _screenSize.width * .95,
        height: _screenSize.height * .15,
        decoration: myBoxDecoration(Colors.green),
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: textosL,
            ),
            Expanded(
              child: SizedBox(),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: textosR),
          ],
        ),
      ),
    ],
  );
}

Widget _loadCreditos(BuildContext context) {
  return FutureBuilder(
    future: CreditoProvider.creditosCliente(Usuario.usr.clienteId),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
      if (snapshot.hasData) {
        return _drawVisitanteItems(snapshot.data, context);
      } else {
        return Container(
            height: 400.0, child: Center(child: CircularProgressIndicator()));
      }
    },
  );
}

Widget _drawVisitanteItems(List<Credito> creditos, BuildContext context) {
  return ListView.separated(
    itemCount: creditos.length,
    itemBuilder: (BuildContext context, int index) {
      return _itemCredito(
          context, creditos[index]); //_drawVisitante(creditos[index], context);
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );
}

class _CreditosPageState extends State<CreditosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        // iconTheme: IconThemeData(
        //   color: pfAzul,
        // ),
        title: Text(
          'Solicita',
          style: TextStyle(
            color: pfAzul,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: _loadCreditos(context),
    );
  }
}
