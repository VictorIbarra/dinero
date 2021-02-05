import 'dart:convert';
import 'package:dineroenunclick/src/models/PromocionModel.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:http/http.dart' as http;

class PromocionProvider {
  PromocionProvider();

  static Future<List<Promocion>> cotizacionCliente(int clienteId) async {
    try {
      final url =
          '$api_url/PromocionesCliente?Cliente_Id=$clienteId&CotizarUltimo=true&SoloSolicitado=false';
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final result = Promocion.fromJsonList(decodedData['Data'], 'PROMC-1');

      Promocion.selCotizacion = result.first;

      return result;
    } catch (Exception) {
      Promocion.selCotizacion.idPromocionCliente = -1;
    }

    //print(decodedData);
  }

  static Future<bool> subirAplicacionCredito(
      {int idSolicitud,
      int idProducto,
      int idSucursal,
      String clabe,
      double saldoCredito,
      String phoneNumber}) async {
    final url = '$api_url/SubirAplicacionCredito';
    Map<String, dynamic> bodyRequest = {
      'IdSolicitud': idSolicitud.toString(),
      'IdProducto': idProducto.toString(),
      'IdSucursal': idSucursal.toString(),
      'Clabe': clabe,
      'SaldoCreditoNuevo': saldoCredito.toString(),
      'Telefono': phoneNumber,
    };

    final resp = await http.post(
      url,
      body: bodyRequest,
    );

    if (resp.statusCode == 200)
      return true;
    else
      return false;
  }
}
