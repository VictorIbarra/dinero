import 'dart:convert';
import 'package:dineroenunclick/src/models/RegistroModel.dart';
import 'package:dineroenunclick/src/models/UsuarioModel.dart';
import 'package:dineroenunclick/src/providers/db_provider.dart';
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider{

  UsuarioProvider();

  Future<Registro> validaCodigoUsuario(String codigo) async{

    Registro reg = new Registro();

    final url = '$api_url/ValidaCodigoUsuario?Codigo=$codigo';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final result = Registro.fromJsonList(decodedData['Data']);

    print(decodedData);

    if(result.length > 0){
      reg = result[0];
      Registro.obj = reg;
    }
    else{
      reg = new Registro();
    }
    
    return reg;

  }

  Future<Usuario> registroUsuario(int clienteId, int promotorId, String nombreCompleto, String pass, String telefono, String direccion, double lineaCreditoMax, String correo, String rfc) async{

    Usuario usr = new Usuario();
    usr.clienteId = clienteId;
    usr.promotorId = promotorId;
    usr.nombreCompleto = nombreCompleto;
    usr.pass = pass;
    usr.telefono = telefono;
    usr.direccion = direccion;
    usr.lineaCreditoMax = lineaCreditoMax;
    usr.correo = correo;
    usr.rfc = rfc;

    String params = usuarioModelToJson(usr, 'register');

    final url = '$api_url/RegistroUsuario';
    final resp = await http.post(url, headers: headers, body: params);
    final decodedData = json.decode(resp.body);

    if(decodedData['Error'] == 0){
      final result = Usuario.fromJsonList(decodedData['Data'], 'RU-1');

      print(decodedData);

      if(result.length > 0){
        usr = result[0];
      }
      else{
        usr = new Usuario();
      }

    }
    else{
      usr.mensaje = decodedData['Message'];
    }
    
    
    return usr;

  }
  static Future<Usuario> login(Usuario usr) async{

    final url = '$api_url/ValidaIngreso';
    final resp = await http.post(url, headers: headers, body: usuarioModelToJson(usr, 'login'));
    final decodedData = json.decode(resp.body);
    final result = Usuario.fromJson(decodedData['Data'][0]);

    usr = result;
    await DBProvider.db.insertUsuario(usr);
    await DBProvider.db.selectUsuario();

    return usr;
  }

  Future<Usuario> validaIngreso(String correo, String pass) async{

    Usuario usr = new Usuario();
    usr.correo = correo;
    usr.pass = pass;

    final url = '$api_url/ValidaIngreso';
    final resp = await http.post(url, headers: headers, body: usuarioModelToJson(usr, 'login'));
    final decodedData = json.decode(resp.body);
    final result = Usuario.fromJsonList(decodedData['Data'], 'LO-1');

    print(decodedData);

    if(result.length > 0){
      usr = result[0];
    }
    else{
      usr = new Usuario();
    }
    
    return usr;

  }

  static Future<Usuario> resetPassword(Usuario usr) async{

    final url = '$api_url/ResetPassword';
    final resp = await http.post(url, headers: headers, body: usuarioModelToJson(usr, 'reset'));
    final decodedData = json.decode(resp.body);

    print(decodedData);

    usr.error = decodedData['Error'];
    usr.mensaje = decodedData['Message'];

    return usr;

  }

  static Future<Usuario> resetNIP(Usuario usr) async{

    final url = '$api_url/ResetNIPPass';
    final resp = await http.post(url, headers: headers, body: usuarioModelToJson(usr, 'resetNIP'));
    final decodedData = json.decode(resp.body);

    print(decodedData);

    usr.error = decodedData['Error'];
    usr.mensaje = decodedData['Message'];

    return usr;

  }

  static Future<String> terminosCondiciones() async{

    final url = '$api_url/TerminosCondiciones';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final result = decodedData['Data'];

    print(decodedData);

    return result;

  }

  static Future<PinData> pinUrl(int idCliente, String latitud, String longitud) async {

    final url = '$api_url/PiN_URL?idCliente=$idCliente&latitud=$latitud&longitud=$longitud';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final result = decodedData['Data'] == null ? null : PinData.fromJson(decodedData['Data']);

    print('$decodedData url de la web view de la api de PIN');

    return result;
  }
}

class PinData {
  final int idEstatus;
  final String estatus;
  final String url;

  PinData({this.idEstatus, this.estatus, this.url});

  factory PinData.fromJson(Map<String, dynamic> json) {
    return PinData(
        idEstatus: json['IdEstatus'],
        estatus: json['Estatus'],
        url: json['PIN_URL']
      );
  }
}
