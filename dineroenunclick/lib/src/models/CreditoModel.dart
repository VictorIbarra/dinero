class Credito {
  final int idSolicutud;
  final int idCuenta;
  final double capital;
  final int plazo;
  final double disponible;
  final double pago;
  final String frecuencia;
  final double tasa;
  final int idProducto;
  final int idConvenio;
  final int idTipoProducto;
  final int idCliente;
  final double saldoCredito;
  final String clabe;
  final int idSucursal;
  final int mesesSaldados;
  final int mesesVida;
  final int pagosRealizados;
  final int diasMora;
  final double saldoCapital;
  final double saldoIntereseIVA;

  Credito(
      {this.idSolicutud,
      this.idCuenta,
      this.capital,
      this.plazo,
      this.disponible,
      this.pago,
      this.frecuencia,
      this.tasa,
      this.idProducto,
      this.idConvenio,
      this.idTipoProducto,
      this.idCliente,
      this.saldoCredito,
      this.clabe,
      this.idSucursal,
      this.mesesSaldados,
      this.mesesVida,
      this.pagosRealizados,
      this.diasMora,
      this.saldoCapital,
      this.saldoIntereseIVA});

  factory Credito.fromJson(Map<String, dynamic> json) {
    return new Credito(
        idSolicutud: json['idsolicitud'],
        idCuenta: json['idCuenta'],
        capital: json['Capital'],
        plazo: json['Plazo'],
        disponible: json['Disponible'],
        pago: json['Pago'],
        frecuencia: json['Frecuencia'],
        tasa: json['Tasa'],
        idProducto: json['IdProducto'],
        idConvenio: json['IdConvenio'],
        idTipoProducto: json['TipoProducto_Id'],
        idCliente: json['idCliente'],
        saldoCredito: json['SaldoCredito'],
        clabe: json['Clabe'],
        idSucursal: json['IdSucursal'],
        mesesSaldados: json['MesesSaldados'],
        mesesVida: json['MesesVida'],
        pagosRealizados: json['PagosRealizados'],
        diasMora: json['DiasMora'],
        saldoCapital: json['sdo_Capital'],
        saldoIntereseIVA: json['sdo_InteresIva']);
  }

  static List<Credito> fromJsonList(List<dynamic> jsonList) {
    List<Credito> items = new List<Credito>();
    if (jsonList != null)
      items = jsonList.map((e) => Credito.fromJson(e)).toList();
    return items;
  }
}
