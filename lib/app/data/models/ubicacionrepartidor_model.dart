import 'package:cloud_firestore/cloud_firestore.dart';

class UbicacionRepartidorModel {
    UbicacionRepartidorModel({
        required this.idUbicacionRepartidor,
        required this.idRepartidor,
        required this.fechaUbicacionRepartidor,
        required this.direccionUbicacionRepartidor,
    });

    final String idUbicacionRepartidor;
    final String idRepartidor;
    final Timestamp fechaUbicacionRepartidor;
    final DireccionUbicacionRepartidor direccionUbicacionRepartidor;

    factory UbicacionRepartidorModel.fromMap(Map<String, dynamic> json) => UbicacionRepartidorModel(
        idUbicacionRepartidor: json["idUbicacionRepartidor"],
        idRepartidor: json["idRepartidor"],
        fechaUbicacionRepartidor: json["fechaUbicacionRepartidor"],
        direccionUbicacionRepartidor: DireccionUbicacionRepartidor.fromMap(json["direccionUbicacionRepartidor"]),
    );

    Map<String, dynamic> toMap() => {
        "idUbicacionRepartidor": idUbicacionRepartidor,
        "idRepartidor": idRepartidor,
        "fechaUbicacionRepartidor": fechaUbicacionRepartidor,
        "direccionUbicacionRepartidor": direccionUbicacionRepartidor.toMap(),
    };
}

class DireccionUbicacionRepartidor {
    DireccionUbicacionRepartidor({
        required this.latitud,
        required this.longitud,
    });

    final String latitud;
    final String longitud;

    factory DireccionUbicacionRepartidor.fromMap(Map<String, dynamic> json) => DireccionUbicacionRepartidor(
        latitud: json["latitud"],
        longitud: json["longitud"],
    );

    Map<String, dynamic> toMap() => {
        "latitud": latitud,
        "longitud": longitud,
    };
}


/*
UbicacionRepartidorModel
 {
      "idUbicacionRepartidor": "", 
       
      "idRepartidor": "",
      "fechaUbicacionRepartidor":"",
      "direccionUbicacionRepartidor":{
          "latitud":"2.0",
          "longitud":"2"
      }
       
    }
*/