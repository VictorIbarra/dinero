import 'dart:convert';

import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:http/http.dart' as http;

class AyudaProvider {
  static Future<AyudaResponse> emailphone(int idCliente) async {
    final url = '$api_url/CentroAyuda?Cliente_Id=$idCliente';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final result = AyudaResponse.fromJson(decodedData);
    return result;
  }
}

class _Sucursal {
  final int id;
  final String sucursal;
  final String telefono;
  final String gerente;
  final String email;
  final String direccion;
  final String colonia;
  final String ciudad;
  final String estado;

  _Sucursal(
      {this.id,
      this.sucursal,
      this.telefono,
      this.gerente,
      this.email,
      this.direccion,
      this.colonia,
      this.ciudad,
      this.estado});

  factory _Sucursal.fromJson(Map<String, dynamic> json) {
    return _Sucursal(
        id: json['IdSucursal'],
        sucursal: json['Sucursal'],
        telefono: json['telefono'],
        gerente: json['gerente'],
        email: json['email'],
        direccion: json['direccion'],
        colonia: json['Colonia'],
        ciudad: json['Ciudad'],
        estado: json['Estato']);
  }
}

class AyudaResponse {
  final String serviceCode;
  final String message;
  final List<_Sucursal> data;

  AyudaResponse({this.serviceCode, this.message, this.data});

  factory AyudaResponse.fromJson(Map<String, dynamic> json) {
    var list = json['Data'] as List;
    List<_Sucursal> sucursalesList =
        list.map((e) => _Sucursal.fromJson(e)).toList();

    return AyudaResponse(
        serviceCode: json['ServiceCode'],
        message: json['Message'],
        data: sucursalesList);
  }
}
