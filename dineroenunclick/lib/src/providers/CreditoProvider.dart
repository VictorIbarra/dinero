import 'dart:convert';
import 'package:dineroenunclick/src/models/CreditoModel.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:http/http.dart' as http;

class CreditoProvider {
  CreditoProvider();

  static Future<List<Credito>> creditosCliente(int clienteId) async {
    final url = '$api_url/CreditosCliente?Cliente_Id=$clienteId';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final result = Credito.fromJsonList(decodedData['Data']);
    print(decodedData);
    return result;
  }
}