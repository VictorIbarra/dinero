import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/NotificasionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/models/NotificasionModel.dart';

class NotificacionesPage extends StatefulWidget {
  NotificacionesPage({Key key}) : super(key: key);
  _NotificacionesPageState createState() => _NotificacionesPageState();
}

BoxDecoration myBoxDecoration(Color color) {
  return BoxDecoration(
    color: Colors.grey[400],
    border: Border.all(width: 1.0, color: color),
    borderRadius:
        BorderRadius.all(Radius.circular(5.0) //         <--- border radius here
            ),
  );
}

Widget _itemNotificacion(BuildContext context, Notificasion prom, Color color) {
  final _screenSize = MediaQuery.of(context).size;
  final marginTop = 5.0;
  final marginLeft = 10.0;
  List<Widget> textos = new List<Widget>();

  textos.add(Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        Icons.add_alert,
        color: pfazul2,
        size: 24.0,
      ),
      Container(
        margin: EdgeInsets.only(left: 01.0),
        child: Column(
          children: [
            Text(
              'Tu préstamo a sido autorizado por la cantidad de',
              style: TextStyle(fontSize: 12.5, color: Colors.white),
            ),
            Text(
                '\$${prom.disponible.toString()}, de tu credito de \$${prom.monto.toString()} esta ${prom.estatus.toString()}',
                style: TextStyle(fontSize: 12.0, color: Colors.white)),
          ],
        ),
      ),
    ],
  ));
  textos.add(SizedBox(
    height: 5.0,
  ));
  return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: marginTop),
            width: _screenSize.width * .99,
            height: _screenSize.height * .1,
            decoration: myBoxDecoration(color),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: textos,
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
}

Widget _loadCreditos(BuildContext context) {
  return FutureBuilder(
    future: NotificasionProvider.creditosCliente(Usuario.usr.clienteId),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data.isEmpty)
          return Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No hay notificaciones',
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
            height: 400.0, child: Center(child: CircularProgressIndicator()));
      }
    },
  );
}

Widget _drawVisitanteItems(List<Notificasion> creditos, BuildContext context) {
  return ListView.separated(
    itemCount: creditos.length,
    itemBuilder: (BuildContext context, int index) {
      return _itemNotificacion(context, creditos[index], pfAzul);
    },
    separatorBuilder: (BuildContext context, int index) => SizedBox(
      height: 10,
    ),
  );
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.view_headline,
                  color: pfazul2,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, '/hola');
                  });
                },
              )
            ],
            title: Center(
              child: Text(
                'Notificaciones',
                style: TextStyle(
                  color: pfazul2,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Montserrat',
                ),
              ),
            )),
        body: _loadCreditos(context));
  }
}