import 'package:dineroenunclick/src/models/CreditoModel.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/CreditoProvider.dart';
import 'package:flutter/material.dart';
import 'package:dineroenunclick/src/utilities/metodos.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:flutter/services.dart';

class CreditosPage extends StatefulWidget {
  CreditosPage({Key key}) : super(key: key);
  _CreditosPageState createState() => _CreditosPageState();
}

BoxDecoration myBoxDecoration(Color color) {
  return BoxDecoration(
    border: Border.all(width: 2.0, color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  );
}

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

class _CreditosPageState extends State<CreditosPage> {
  Widget _loadCreditos(BuildContext context) {
    return FutureBuilder(
      future: CreditoProvider.creditosCliente(Usuario.usr.clienteId),
      builder: (BuildContext context, AsyncSnapshot<List<Credito>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty)
            return Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No cuentas con créditos a renovar',
                    textScaleFactor: 1.3,
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  new Image.asset(
                    'assets/13.png',
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            );
          return _drawVisitanteItems(snapshot.data, context);
        } else {
          return Container(
              height: 600.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _itemCredito(BuildContext context, Credito item) {
    final _screenSize = MediaQuery.of(context).size;
    final marginTop = 10.0;
    final marginLeft = 20.0;
    double _currentSliderValue = 10;

    List<Widget> textosL = new List<Widget>();
    textosL.add(Container(
      margin: EdgeInsets.only(left: marginLeft),
      child: Column(
        children: [
          Text('Disponible', style: _textStyle('hBold', pfazul2)),
          SizedBox(height: 30),
          Slider(
            value: _currentSliderValue,
            min: 0,
            max: 100,
            divisions: 30,
            label: _currentSliderValue.round().toString(),
            activeColor: pfazul2,
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
              print(_currentSliderValue.toString());
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            width: MediaQuery.of(context).size.width * .6,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {},
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: pfVerde2,
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
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    ));

    textosL.add(Container(
      margin: EdgeInsets.only(top: marginTop, left: 10.0),
      width: 360,
      height: 60.0,
      decoration: myBoxDecoration(Colors.green),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'MONTO DISPONIBLE',
                style: TextStyle(fontSize: 10.0, color: pffgris2),
              ),
              Text('       '),
              Text(
                'PLAZO',
                style: TextStyle(fontSize: 10.0, color: pffgris2),
              ),
              Text('       '),
              Text(
                'PAGO MENUAL',
                style: TextStyle(fontSize: 10.0, color: pffgris2),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Row(
            children: [
              Text('\$${comma(item.disponible?.toString())}',
                  style: TextStyle(color: pfazul2, fontSize: 18.0)),
              Row(
                children: [
                  Text(' ${comma(item.plazo?.toString())}',
                      style: TextStyle(color: pfazul2, fontSize: 18.0)),
                  Text(
                    ' ${item.frecuencia == 'M' ? 'Meses' : 'Quincenas'}',
                    style: TextStyle(color: pfazul2, fontSize: 18.0),
                  ),
                ],
              ),
              Text('\$${comma(item.pago?.toString())}',
                  style: TextStyle(color: pfazul2, fontSize: 18.0)),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ],
      ),
    ));

    textosL.add(Container(
      margin: EdgeInsets.only(top: marginTop, left: 15.0),
      width: 360,
      height: 60.0,
      decoration: myBoxDecoration(Colors.green),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '  MONTO ',
                style: TextStyle(fontSize: 10.0, color: pffgris2),
              ),
              Text('       '),
              Text(
                '   PLAZO',
                style: TextStyle(fontSize: 10.0, color: pffgris2),
              ),
              Text('       '),
              Text(
                '    PAGO MENUAL',
                style: TextStyle(fontSize: 10.0, color: pffgris2),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Row(
            children: [
              Text('\$${comma(item.capital?.toString())}',
                  style: TextStyle(color: pfazul2, fontSize: 18.0)),
              Row(
                children: [
                  Text(' ${comma(item.plazo?.toString())}',
                      style: TextStyle(color: pfazul2, fontSize: 18.0)),
                  Text(
                    ' ${item.frecuencia == 'M' ? 'Meses' : 'Quincenas'}',
                    style: TextStyle(color: pfazul2, fontSize: 18.0),
                  ),
                ],
              ),
              Text('\$${comma(item.pago?.toString())}',
                  style: TextStyle(
                    color: pfazul2,
                    fontSize: 18.0,
                  )),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ],
      ),
    ));

    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, '/promocionDetalle',
            arguments: item);
        setState(() => {});
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: marginTop),
            //tamano de la caja
            width: _screenSize.width * .95,
            height: _screenSize.height * .40,
            decoration: myBoxDecoration(Colors.green),
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: textosL,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawVisitanteItems(List<Credito> creditos, BuildContext context) {
    return ListView.separated(
      itemCount: creditos.length,
      itemBuilder: (BuildContext context, int index) {
        return _itemCredito(context, creditos[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Solicita',
          style: TextStyle(
            color: pfazul2,
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
