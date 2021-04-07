import 'dart:convert';

class Usuario {
  static int idCliente = 0;
  static Usuario usr;

  int idUsuarioCliente;
  int clienteId;
  int promotorId;
  String nombreCompleto;
  String correo;
  String rfc;
  String nip;
  String pass;
  String telefono;
  String direccion;
  double lineaCreditoMax;
  DateTime fecAlta;
  bool activo;
  bool clientePF;
  int error;
  String mensaje;
  int usuarioClienteId;
  String clabe;
  String claveRegistroPiN;
  String pantallaPrincipal;

  Usuario(
      {this.idUsuarioCliente,
      this.clienteId,
      this.promotorId,
      this.nombreCompleto,
      this.correo,
      this.rfc,
      this.nip,
      this.pass,
      this.telefono,
      this.direccion,
      this.lineaCreditoMax,
      this.fecAlta,
      this.activo,
      this.error,
      this.mensaje,
      this.usuarioClienteId,
      this.claveRegistroPiN,
      this.clabe,
      this.clientePF,
      this.pantallaPrincipal});

  Usuario.fromJsonMap(Map<String, dynamic> json, String type) {
    switch (type) {
      case 'RU-1':
        error = json['Error'];
        mensaje = json['Mensaje'];
        usuarioClienteId = json['UsuarioCliente_Id'];
        break;
      case 'LO-1':
        clienteId = int.parse(json['Cliente_Id'].toString().split('.')[0]);
        promotorId = (json['Promotor_Id']);
        nombreCompleto = json['NombreCompleto'];
        rfc = json['RFC'];
        correo = json['Correo'];
        telefono = (json['Telefono']);
        direccion = json['Direccion'];
        lineaCreditoMax = (json['LineaCreditoMax']);
        clabe = (json['Clabe']);
        claveRegistroPiN = (json['ClaveRegistroPiN']);
        clientePF = json['ClientePF'];
        pantallaPrincipal = json['PantallaPrincipal'];
        break;
    }
  }

  static List<Usuario> fromJsonList(
      List<dynamic> jsonList, String serviceCode) {
    List<Usuario> items = new List();
    try {
      for (var item in jsonList) {
        final usr = new Usuario.fromJsonMap(item, serviceCode);
        items.add(usr);
      }

      return items;
    } catch (Exception) {
      return items;
    }
  }

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuarioCliente: json['IdUsuarioCliente'],
        clienteId: json['Cliente_Id'],
        promotorId: json['Promotor_Id'],
        nombreCompleto: json['NombreCompleto'],
        rfc: json['RFC'],
        correo: json['Correo'],
        telefono: json['Telefono'],
        direccion: json['Direccion'],
        lineaCreditoMax: json['LineaCreditoMax'],
        clientePF: json['ClientePF'] == 1
            ? true
            : json['ClientePF'] == true
                ? true
                : false,
        pantallaPrincipal: json['PantallaPrincipal'],
        claveRegistroPiN: json['ClaveRegistroPiN'],
        clabe: json['Clabe'],
      );

  Map<String, dynamic> toJson() => {
        'Cliente_Id': clienteId,
        'Promotor_Id': promotorId,
        'NombreCompleto': nombreCompleto,
        'Correo': correo,
        'RFC': rfc,
        'Pass': pass,
        'Telefono': telefono,
        'Direccion': direccion,
        'LineaCreditoMax': lineaCreditoMax,
        'ClientePF': clientePF,
        'PantallaPrincipal': pantallaPrincipal,
      };

  Map<String, dynamic> toJsonLoginResponse() => {
        'Cliente_Id': clienteId,
        'Promotor_Id': promotorId,
        'NombreCompleto': nombreCompleto,
        'RFC': rfc,
        'Correo': correo,
        'Telefono': telefono,
        'LineaCreditoMax': lineaCreditoMax,
        'ClaveRegistroPiN': claveRegistroPiN,
        'Clabe': clabe,
        'ClientePF': clientePF,
        'PantallaPrincipal': pantallaPrincipal,
        'IdUsuarioCliente': idUsuarioCliente
      };

  Map<String, dynamic> toJsonLogin() => {
        'Correo': correo,
        'Pass': pass,
      };

  Map<String, dynamic> toJsonReset() => {
        'Correo': correo,
      };

  Map<String, dynamic> toJsonResetNIP() =>
      {'Cliente_Id': clienteId, 'Nip': nip, 'Pass': pass};
}

String usuarioModelToJson(Usuario data, String type) {
  switch (type) {
    case 'login':
      return json.encode(data.toJsonLogin());
      break;
    case 'register':
      return json.encode(data.toJson());
      break;
    case 'reset':
      return json.encode(data.toJsonReset());
      break;
    case 'resetNIP':
      return json.encode(data.toJsonResetNIP());
      break;
    default:
      return null;
      break;
  }
}
