import 'dart:convert';

class Notificasion {
  static Notificasion selPROM = new Notificasion();
  static Notificasion selCotizacion = new Notificasion();

  int idFolio;
  String estatus;
  double monto;
  double disponible;

  Notificasion({
    this.idFolio,
    this.estatus,
    this.monto,
    this.disponible,
  });

  Notificasion.fromJsonMap(Map<String, dynamic> json, String type) {
    switch (type) {
      case 'NOC-1':
        idFolio = json['IdFolio'];
        monto = json['MontoRenovacion'];
        estatus = json['Estatus'];
        disponible = json['Disponible'];
        break;
    }
  }

  static List<Notificasion> fromJsonList(
      List<dynamic> jsonList, String serviceCode) {
    List<Notificasion> items = new List();

    try {
      for (var item in jsonList) {
        final usr = new Notificasion.fromJsonMap(item, serviceCode);
        items.add(usr);
      }
      return items;
    } catch (Exception) {
      return items;
    }
  }
}
