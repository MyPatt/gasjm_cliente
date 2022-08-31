class UbicacionRepartidor {
    UbicacionRepartidor({
        required this.idRutaRepartidor,
        required this.idRepartidor,
        required this.direccionRepartidor,
    });

    final String idRutaRepartidor;
    final String idRepartidor;
    final DireccionRepartidor direccionRepartidor;

    factory UbicacionRepartidor.fromMap(Map<String, dynamic> json) => UbicacionRepartidor(
        idRutaRepartidor: json["idRutaRepartidor"],
        idRepartidor: json["idRepartidor"],
        direccionRepartidor: DireccionRepartidor.fromMap(json["direccionRepartidor"]),
    );

    Map<String, dynamic> toMap() => {
        "idRutaRepartidor": idRutaRepartidor,
        "idRepartidor": idRepartidor,
        "direccionRepartidor": direccionRepartidor.toMap(),
    };
}

class DireccionRepartidor {
    DireccionRepartidor({
        required this.latitud,
        required this.longitud,
    });

    final String latitud;
    final String longitud;

    factory DireccionRepartidor.fromMap(Map<String, dynamic> json) => DireccionRepartidor(
        latitud: json["latitud"],
        longitud: json["longitud"],
    );

    Map<String, dynamic> toMap() => {
        "latitud": latitud,
        "longitud": longitud,
    };
}

/*
 {
      "idRutaRepartidor": "", 
       
      "idRepartidor": "",
      "direccionRepartidor":{
          "latitud":'2.0',
          "longitud":'2'
      }
       
    }
*/