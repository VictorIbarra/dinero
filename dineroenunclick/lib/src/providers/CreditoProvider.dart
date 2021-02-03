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

/*   static Future<Credito> altaCreditoPromocion(int clienteId, int promocionId,
      int productoId, double capital, double erogacion) async {
    Credito cred = new Credito();
    cred.idCuenta = clienteId;
    cred.idPromocion = promocionId;
    cred.idProducto = productoId;
    cred.capital = capital;
    cred.erogacion = erogacion;

    String params = creditoModelToJson(cred, 'alta');

    final url = '$api_url/AltaCreditoPromocion';
    final resp = await http.post(url, headers: headers, body: params);
    final decodedData = json.decode(resp.body);

    print("FK-1: params: " + params);

    print(decodedData);

    if (decodedData['Error'] == 0) {
      return cred;
    } else {
      return new Credito();
    }
  } */

/*   static Future<Credito> altaCredito(
      int clienteId,
      int promocionId,
      double capital,
      double erogacion,
      int pendientes,
      int pagados,
      String clabe) async {
    Credito cred = new Credito();
    cred.idCuenta = clienteId;
    cred.idProducto = promocionId;
    cred.capital = capital;
    cred.erogacion = erogacion;
    cred.pendientes = pendientes;
    cred.pagados = pagados;
    cred.clabe = clabe;

    String params = creditoModelToJson(cred, 'alta');

    final url = '$api_url/AltaCredito';
    final resp = await http.post(url, headers: headers, body: params);
    final decodedData = json.decode(resp.body);

    print(decodedData);

    if (decodedData['Error'] == 0) {
      return cred;
    } else {
      return new Credito();
    }
  } */
}
