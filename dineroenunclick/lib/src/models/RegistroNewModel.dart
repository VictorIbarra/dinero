class RegistroNew {
  int idCliente;
  String cliente;
  String celular;
  int idPromotor;
  int idProducto;
  double capital;
  double erogacion;

  static RegistroNew obj;

  RegistroNew(
      {this.idCliente,
      this.cliente,
      this.celular,
      this.idPromotor,
      this.idProducto,
      this.capital,
      this.erogacion});

  RegistroNew.fromJsonMap(Map<String, dynamic> json) {
    //idUsuarioCliente = int.parse(json['Id_UsuarioCliente']);
    idCliente = int.parse(json['IdCliente'].toString().split('.')[0]);
    cliente = (json['Cliente']);
    celular = json['Celular'];
    idPromotor = json['IdPromotor'];
    idProducto = (json['IdProducto']);
    capital = json['Capital'];
    erogacion = (json['Erogacion']);
  }

  static List<RegistroNew> fromJsonList(List<dynamic> jsonList) {
    List<RegistroNew> items = new List();
    for (var item in jsonList) {
      final reg = new RegistroNew.fromJsonMap(item);
      items.add(reg);
    }

    return items;
  }
}
