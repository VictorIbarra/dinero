
import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario{
  
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();
  
  factory PreferenciasUsuario(){
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  

  //GET y SET de huella
  get huella {
    return _prefs.getBool('huella') ?? false;
  }

  set huella(bool valor){
    _prefs.setBool('huella', valor);
  }


  //GET y SET de ip de WebServices
  get ip {
    return _prefs.getString('ip') ?? ip_default;
  }

  set ip (String valor){
    _prefs.setString('ip', valor);
  }


  //GET y SET de Latitud
  get latitud {
    return _prefs.getString('latitud') ?? "0";
  }

  set latitud (String valor){
    _prefs.setString('latitud', valor);
  }


  //GET y SET de Latitud
  get longitud {
    return _prefs.getString('longitud') ?? "0";
  }

  set longitud (String valor){
    _prefs.setString('longitud', valor);
  }




}