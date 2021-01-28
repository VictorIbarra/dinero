import 'dart:collection';
import 'dart:math';

import 'package:dineroenunclick/src/models/PromocionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:dineroenunclick/src/utilities/metodos.dart';

class SolicitaPage extends StatefulWidget {
  SolicitaPage({Key key}) : super(key: key);

  _SolicitaPageState createState() => _SolicitaPageState();
}

class _SolicitaPageState extends State<SolicitaPage> with AutomaticKeepAliveClientMixin<SolicitaPage>{

  double mensual = 3000/24;
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

  _modalInfoAmpliacion(BuildContext context) async {
    
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enviar Solicitud !'),
            content: Container(
              child: Text('Contactate con alguna de nuestras sucursales.'),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.pop(context);
                 },
              ),
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
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
        onPressed: () async{
           _modalInfoAmpliacion(context);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: pfVerde,
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

            SizedBox(width: 15,),

            Icon(Icons.check, color: Colors.white)

          ],
        )
        
      ),
    );
  }


  int _calPago(double capital, double pagos, double tasa, int frecAnual){

    if(prom.frecuencia == 'M'){frecAnual = 12;}
    if(prom.frecuencia == 'Q'){frecAnual = 24;}

    plazosRangos.forEach((k,v){
      
      if(k == pagos){
        tasa = v;
      }
    }); 


    double factorTasa = tasa/100;
    double fTasaFrec = factorTasa/frecAnual;
    double conIva = fTasaFrec * 1.16;
    double pagoBase = conIva * capital;

    double pagoDiff = 1 - (pow((1+conIva), (pagos*-1)));
    double erogacion = pagoBase/pagoDiff;

    erogacionFinal = int.parse(erogacion.toString().split('.')[0]) * 1.0;

    return erogacionFinal.round();

  }

  int _calDivisiones(double montoMin, double montoMax){
    int factor = 500;
    int montoReal = ((montoMax - montoMin).round());
    int steps = 10;

    if(montoMax < 30000){ factor = 500; }
    else if(montoMax >= 30000 && montoMax < 50000){ factor = 1000; }
    else if(montoMax >= 50000 && montoMax < 100000){ factor = 1000; }
    else if(montoMax >= 100000){ factor = 1000; }

    steps = (montoReal/factor).round();

    return steps;

  }

  HashMap _setPlazos(String productos, String frec){
    //productos = 'Q,6,113.7931034|  Q,8,110.0689655|  Q,10,106.4482759|  Q,12,102.7241379|  Q,14,99.0000000|  Q,16,95.2758621|  Q,18,91.6551724|  Q,20,87.9310345|';

    List<String> plazos = productos.split('|');
    HashMap rangos = new HashMap<dynamic, dynamic>();

    int first = 0;
    int last = 0;
    int steps = 1;

    int pagos = 0;
    double tasa = 0;
    int prodId = 0;

    plazos.forEach((prod){
      var obj = prod.trim().split(',');

      if(obj[0] == frec && double.parse(obj[2]) == prom.tasa){
        pagos = int.parse(obj[1]);
        tasa = double.parse(obj[2]);
        prodId = int.parse(obj[3]);
        if(first == 0){first = pagos; }

        rangos.addAll({pagos: tasa});
      }

    });

    if(rangos.length == 0){
      prom.tasa = double.parse(plazos[0].split(',')[2]);
      plazos.forEach((prod){
        var obj = prod.trim().split(',');

        if(obj[0] == frec && double.parse(obj[2]) == prom.tasa){
          pagos = int.parse(obj[1]);
          tasa = double.parse(obj[2]);
          prodId = int.parse(obj[3]);
          if(first == 0){first = pagos; }

          rangos.addAll({pagos: tasa});
        }
      });
    }



    rangos.forEach((key, value) { 
      rangosSlider.add(key);
    });

    rangosSlider.sort((a, b) {
      return a.compareTo(b);
    });

    print(rangosSlider);

    last = pagos;

    steps = (rangos.length -1);//((last - first)/(rangos.length-1)).round();

    plazosDiv = steps;
    plazosMin = first*1.0;
    plazosMax = last*1.0;
    plazosVal = plazosMax;
    plazosValSlider = plazosMax;

    setState(() {
      
    });


    return rangos;


  }



   @override
  void initState() {

    if(Promocion.selCotizacion.idPromocionCliente != -1){
      prom = Promocion.selCotizacion;
      monto = prom.monto;
      divisiones = _calDivisiones(1000, monto);
      print(prom.productos);
      plazosRangos = _setPlazos(prom.productos, prom.frecuencia);

    }
    
    getCurrentLocation((){
      print('this is your location');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if(Promocion.selCotizacion.idPromocionCliente != -1){
      return Container(
      padding: EdgeInsets.all(20.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[

           //Icon(Icons.attach_money, size: 120.0, color: Color(0xFF21D702),),
           Text('\$', style: TextStyle(
             color: Color(0xFF21D702),
             fontSize: 80.0,
             fontWeight: FontWeight.w900,
             fontFamily: 'Montserrat',
             )
          ),
           
           Text('Disponible', style: kLabelHeader),

                SizedBox(height: 30.0,),
                
                Text('Monto', style: kLabelMiniHeader),
                Text('\$${comma(monto.round().toString())}', style: kLabelHeader,),

                Slider.adaptive(
                  value: monto,
                  min: 1000,
                  max: Promocion.selCotizacion.monto,
                  onChanged: (valor){
                    setState(() {
                      monto = valor;
                    });               
                  },
                  activeColor: pfAzul,
                  divisions: divisiones,
                ),

                SizedBox(height: 30.0,),

                Text('Plazo en '+(prom.frecuencia == 'M' ? 'mensualidades' : 'quincenas'), style: kLabelMiniHeader),
                Text('${plazosVal.round()}', style: kLabelHeader,),

                Slider.adaptive(
                  value: plazosValSlider,
                  min: plazosMin,
                  max: plazosMax,
                  onChanged: (valor){
                    setState(() {
                      plazosValSlider = valor;
                      //print(valor);
                      int step = (valor/((((plazosMax-plazosMin)-1)/plazosDiv))).round();
                      //print(step);
                      //print(rangosSlider[step-1]);
                      plazosVal = double.parse(rangosSlider[step-1].toString());
                    });               
                  },
                  activeColor: pfAzul,
                  divisions: plazosDiv,
                ),
                
                SizedBox(height: 30,),

                Text('\$${comma((_calPago(monto, plazosVal, prom.tasa, 0)).round().toString())}', style: kLabelHeader,),
                Text('Pago '+(prom.frecuencia == 'M' ? 'Mensual' : 'Quincenal'), style: kLabelMiniHeader),

                //Expanded(child: SizedBox(),),

                SizedBox(height: 30,),

           Expanded(child: SizedBox(),),

           _buildContinuarBtn(context),
           



         ],
       )
    );
  

    }
    else{
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('De momento no tiene ofertas.', style: kLabelHeader),
         ],
       )
    );
    }
    
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}