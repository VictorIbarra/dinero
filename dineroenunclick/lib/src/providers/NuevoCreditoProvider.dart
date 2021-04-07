import 'dart:convert';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:http/http.dart' as http;

class NuevoCreditoProvider {
  static Future<bool> submitPrellenado(
      String nombre, String apellido, String correo, String celular) async {
    final url =
        '$api_url/ClientePrellenadoALT?Nombres=$nombre&ApellidoP=$apellido&Correo=$correo&Celular=$celular';
    final res = await http.post(url);
    print(res);
    final decoded = json.decode(res.body);
    return decoded['Error'] != null && decoded['Error'] == 0;
  }
}