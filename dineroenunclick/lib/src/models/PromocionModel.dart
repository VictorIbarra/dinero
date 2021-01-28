import 'dart:convert';

class Promocion{

  static Promocion selPROM = new Promocion();
  static Promocion selCotizacion = new Promocion();

  int idPromocionCliente;
  int promocionId;
  double monto;
  String titulo;
  String subTitulo;
  double tasa;
  int pagos;
  String frecuencia;
  int idConvenio;
  String productos;
  String clabe;


  Promocion({
    this.idPromocionCliente,
    this.promocionId,
    this.monto,
    this.titulo,
    this.subTitulo,
    this.tasa,
    this.pagos,
    this.frecuencia,
    this.idConvenio,
    this.productos,
    this.clabe
  });

  Promocion.fromJsonMap(Map<String, dynamic> json, String type){

    switch(type){
      case 'PROMC-1':
        idPromocionCliente  = json['Id_PromocionCliente'];
        promocionId         = json['Promocion_Id'];
        monto               = json['Monto'];
        titulo              = json['Titulo'];
        subTitulo           = json['SubTitulo'];
        tasa                = json['Tasa'];
        pagos               = int.parse(json['Pagos'].toString().split('.')[0]);
        frecuencia          = json['Frecuencia'];
        idConvenio          = json['IdConvenio'];
        productos           = json['Productos'];
        clabe               = json['Clabe'];
      break;
    }
  }

  static List<Promocion> fromJsonList(List<dynamic> jsonList, String serviceCode){
    
    List<Promocion> items = new List();
    
    try{
      for(var item in jsonList){
        final usr = new Promocion.fromJsonMap(item, serviceCode);
        items.add(usr);
      }
      return items;
    }
    catch(Exception){
      return items;
    }
  }


}