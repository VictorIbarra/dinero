import 'dart:convert';

import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:http/http.dart' as http;

class UsuarioProvisional {
  int idUsuarioCliente;

  UsuarioProvisional({this.idUsuarioCliente});

  factory UsuarioProvisional.fromJson(Map<String, dynamic> json) =>
      UsuarioProvisional(idUsuarioCliente: json['UsuarioCliente_Id']);
}

class RegistroProvisionalProvider {
  static Future<UsuarioProvisional> registrarUsuario(
      String rfc, String correo, String telefono, String password) async {
    final url = '$api_url/RegistroUsuarioProvisional';
    Map<String, dynamic> body = {
      "RFC": rfc,
      "Correo": correo,
      "Telefono": telefono,
      "Pass": password,
    };
    final res = await http.post(url, headers: headers, body: json.encode(body));
    final decodedData = json.decode(res.body);

    final result = decodedData['Data'] == null
        ? null
        : decodedData['Data'][0] == null
            ? null
            : decodedData['Data'][0];

    if (result != null) return UsuarioProvisional.fromJson(result);

    return null;
  }
}
