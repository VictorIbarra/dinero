import 'dart:collection';

import 'package:dineroenunclick/src/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';

bool validaVacio(String value){

  if(value.trim().length >= 2){
    return true;
  }
  else{
    return false;
  }

}

Function mathFunc = (Match match) => '${match[1]},';

String comma(String monto){
    return monto.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), mathFunc);
  }

bool validaCombo(String value){

  if(value.trim() == '0'){
    return false;
  }
  else{
    return true;
  }

}

void getCurrentLocation(Function callback) {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  
  geolocator
    .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
    .then((Position position) {
      prefs.latitud = position.latitude.toString();
      prefs.longitud = position.longitude.toString();
      print("Lat: ${position.latitude}, Lon:${position.longitude}");
      callback();    
    }).catchError((e) {
      print(e);
    });
}

