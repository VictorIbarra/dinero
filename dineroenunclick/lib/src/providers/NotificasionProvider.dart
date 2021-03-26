import 'dart:convert';
import 'package:dineroenunclick/src/models/NotificasionModel.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:http/http.dart' as http;

class NotificasionProvider{

  NotificasionProvider(){
  }
  
  static Future<List<Notificasion>> creditosCliente(int clienteId) async{
    final url = '$api_url/Notificaciones?Cliente_Id=$clienteId';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final result = Notificasion.fromJsonList(decodedData['Data'], 'NOC-1');
    return result;
  }
}