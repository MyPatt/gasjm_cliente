class VehiculoModel {
    VehiculoModel({
        required this.idVehiculo,
        required this.modeloVehiculo,
        required this.idTipoVehiculo,
        required this.idRepartidorVehiculo,
         this.descripcionVehiculo,
    });

    final String idVehiculo;
    final String modeloVehiculo;
    final String idTipoVehiculo;
    final String idRepartidorVehiculo;
    final String? descripcionVehiculo;

    factory VehiculoModel.fromMap(Map<String, dynamic> json) => VehiculoModel(
        idVehiculo: json["idVehiculo"],
        modeloVehiculo: json["modeloVehiculo"],
        idTipoVehiculo: json["idTipoVehiculo"],
        idRepartidorVehiculo: json["idRepartidorVehiculo"],
        descripcionVehiculo: json["descripcionVehiculo"],
    );

    Map<String, dynamic> toMap() => {
        "idVehiculo": idVehiculo,
        "modeloVehiculo": modeloVehiculo,
        "idTipoVehiculo": idTipoVehiculo,
        "idRepartidorVehiculo": idRepartidorVehiculo,
        "descripcionVehiculo": descripcionVehiculo,
    };
}
