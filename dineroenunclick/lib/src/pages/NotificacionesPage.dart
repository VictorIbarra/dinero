import 'package:dineroenunclick/src/models/PromocionModel.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/PromocionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';

class NotificacionesPage extends StatefulWidget {
  NotificacionesPage({Key key}) : super(key: key);

  _NotificacionesPageState createState() => _NotificacionesPageState();
}

BoxDecoration myBoxDecoration(Color color) {
  return BoxDecoration(
    border: Border.all(
      width: 1.0,
      color: color
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(5.0) //         <--- border radius here
    ),
  );
}

TextStyle _textStyle(String tipo, Color color){

  TextStyle ts = TextStyle();

  switch(tipo){
    case 'hBold':
      ts = TextStyle(
        color: color,
        fontSize: 20.0,
        fontWeight: FontWeight.w900,
        fontFamily: 'Montserrat',
      );    
    break;
    case 'hLight':
      ts = TextStyle(
      color: color,
      fontSize: 18.0,
      fontFamily: 'Montserrat',
    );
    break;
    case 'sBold':
      ts = TextStyle(
        color: color,
        fontSize: 12.0,
        fontWeight: FontWeight.w900,
        fontFamily: 'Montserrat',
      );
    break;
  }

  return ts;

}

Widget _itemNotificacion(BuildContext context, Promocion prom, Color color){
  final _screenSize = MediaQuery.of(context).size;
  final marginTop = 5.0;
  final marginLeft = 10.0;

  List<Widget> textos = new List<Widget>();

  if(prom.subTitulo == null || prom.subTitulo == ''){
    textos.add(Container(
                  margin: EdgeInsets.only(left: marginLeft),
                  child: Text(prom.titulo, style: _textStyle('hBold', color)),
                ));
  }
  else{
    textos.add(Container(
                  margin: EdgeInsets.only(left: marginLeft),
                  child: Text(prom.titulo, style: _textStyle('hLight', color)),
                ));
    textos.add(SizedBox(height: 5.0,));
    textos.add(Container(
                  margin: EdgeInsets.only(left: marginLeft),
                  child: Text(prom.subTitulo, style: _textStyle('sBold', Colors.black54)),
                ));

  }

  return GestureDetector(
    onTap: (){
      print('Seleccionaste ${prom.promocionId}');
      Promocion.selPROM = prom;
      Navigator.pushNamed(context, '/promocionDetalle', arguments: prom);
      //Navigator.pushNamed(context, '/promocionDetalle');
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: marginTop),
          width: _screenSize.width * .95,
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
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.keyboard_arrow_right, color: color,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    )
  );

}

Widget _loadCreditos(BuildContext context){
  return FutureBuilder(
    future: PromocionProvider.creditosCliente(Usuario.usr.clienteId),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return _drawVisitanteItems(snapshot.data, context);
        }
        else{
          return Container(
            height: 400.0,
            child: Center( child: CircularProgressIndicator())
          );
        }
      },
  );
}

Widget _drawVisitanteItems(List<Promocion> creditos, BuildContext context){

    return ListView.separated(
      itemCount: creditos.length,
      itemBuilder: (BuildContext context, int index) {
        return _itemNotificacion(context, creditos[index], pfAzul);//_drawVisitante(creditos[index], context);
      },
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10,),
    );

  }




class _NotificacionesPageState extends State<NotificacionesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Notificaciones', style: TextStyle(
             color: pfVerde,
             fontSize: 30.0,
             fontWeight: FontWeight.w900,
             fontFamily: 'Montserrat',
             ),),
      ),
      body: _loadCreditos(context)
      /*body: SingleChildScrollView(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Text('\$', style: TextStyle(
                color: Color(0xFF21D702),
                fontSize: 50.0,
                fontWeight: FontWeight.w900,
                fontFamily: 'Montserrat',
                )
              ),
            ),

            _itemNotificacion(context, 'Renueva tu Crédito', null, pfAzul),
            _itemNotificacion(context, '\$ para tus vacaciones', '¡Fácil y rápido!', pfAzul),
            _itemNotificacion(context, '\$ para el regreso a clases', 'Contacta a alguno de nuestros asesores', pfAzul),


            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Icon(Icons.location_on, color: pfRojo, size: 50.0,)
              ),
            

            _itemNotificacion(context, 'Ya es hora de comer!', '¿Dónde ahorrarás hoy con PiN?', pfRojo),
            _itemNotificacion(context, '¿Reunión Familiar?', 'Ahorra \$ con PiN', pfRojo),
            _itemNotificacion(context, 'Gana hasta \$100 MXN. *', 'Por cada amigo que compre PiN', pfRojo),
            _itemNotificacion(context, 'Ya es hora de comer!', '¿Dónde ahorrarás hoy con PiN?', pfRojo),

          ],
        ),
      ),*/
      
    );
  }
}