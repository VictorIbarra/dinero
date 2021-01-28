import 'dart:convert';
import 'package:dineroenunclick/src/models/PromocionModel.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:http/http.dart' as http;


class PromocionProvider{

  PromocionProvider(){

  }

  static Future<List<Promocion>> creditosCliente(int clienteId) async{

    final url = '$api_url/PromocionesCliente?Cliente_Id=$clienteId';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final result = Promocion.fromJsonList(decodedData['Data'], 'PROMC-1');

    print('$decodedData e perrillo');
      print('$result e perrillo 3');


    return result;
    

  }

  static Future<List<Promocion>> cotizacionCliente(int clienteId) async{

    

    try{
      final url = '$api_url/PromocionesCliente?Cliente_Id=$clienteId&CotizarUltimo=true&SoloSolicitado=false';
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final result = Promocion.fromJsonList(decodedData['Data'], 'PROMC-1');

      Promocion.selCotizacion = result.first;

      return result;
    }
    catch(Exception){
      Promocion.selCotizacion.idPromocionCliente = -1;

    }

    

    //print(decodedData);

    

  }

}