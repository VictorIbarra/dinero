import 'dart:convert';

class Credito{

  int idCuenta;
  int idProducto;
  double capital;
  double erogacion;
  int idConvenio;
  double tasa;
  int pagos;
  String frecuencia;
  int pendientes;
  int pagados;
  double saldo;
  String fchRecibo;
  String clabe;
  String banco;
  int idPromocion;

  Credito({
    this.idCuenta,
    this.idProducto,
    this.capital,
    this.erogacion,
    this.idConvenio,
    this.tasa,
    this.pagos,
    this.frecuencia,
    this.pendientes,
    this.pagados,
    this.saldo,
    this.fchRecibo,
    this.clabe,
    this.banco,
    this.idPromocion
  });

  Credito.fromJsonMap(Map<String, dynamic> json, String type){

    switch(type){
      case 'CC-1':
        idCuenta    = int.parse(json['IdCuenta'].toString().split('.')[0]);
        idProducto  = json['IdProducto'];
        capital     = json['Capital'];
        erogacion   = json['Erogacion'];
        idConvenio  = json['IdConvenio'];
        tasa        = json['Tasa'];
        pagos       = int.parse(json['Pagos'].toString().split('.')[0]);
        frecuencia  = json['Frecuencia'];
        pendientes  = json['Pendientes'];
        pagados     = json['Pagados'];
        saldo       = json['Saldo'];
        fchRecibo   = json['fch_Recibo'].toString().split('T')[0];
        clabe       = json['Clabe'];
        banco       = json['Banco'];
      break;
    }
  }

  static List<Credito> fromJsonList(List<dynamic> jsonList, String serviceCode){
    
    List<Credito> items = new List();
    
    try{
      
      for(var item in jsonList){
        final usr = new Credito.fromJsonMap(item, serviceCode);
        items.add(usr);
      }

      return items;
    }
    catch(Exception){
      return items;
    }
  }

  Map<String, dynamic> toJsonFake() =>{
    'Cliente_Id': idCuenta,
    'Promocion_Id': idProducto,
    'Capital': capital,
    'Erogacion': erogacion,
    'Pendientes': pendientes,
    'Pagados': pagados,
    'Clabe': clabe,
  };

  Map<String, dynamic> toJsonAltaCreditoPromocion() =>{
    'Cliente_Id': idCuenta,
    'Promocion_Id': idPromocion,
    'Producto_Id': idProducto,
    'Capital': capital,
    'Erogacion': erogacion,
  };

  

}

String creditoModelToJson(Credito data, String type){

  switch(type){
    case 'alta_fake':
      return json.encode(data.toJsonFake());
    break;

    case 'alta':
      return json.encode(data.toJsonAltaCreditoPromocion());
    break;
  }
  
  

}
