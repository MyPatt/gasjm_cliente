import 'package:equatable/equatable.dart';

class TipoVehiculoModel extends Equatable {
    TipoVehiculoModel({
        required this.idTipoVehiculo,
        required this.nombreTipoVehiculo,
    });

    final String idTipoVehiculo;
    final String nombreTipoVehiculo;

    factory TipoVehiculoModel.fromMap(Map<String, dynamic> json) => TipoVehiculoModel(
        idTipoVehiculo: json["idTipoVehiculo"],
        nombreTipoVehiculo: json["nombreTipoVehiculo"],
    );

    Map<String, dynamic> toMap() => {
        "idTipoVehiculo": idTipoVehiculo,
        "nombreTipoVehiculo": nombreTipoVehiculo,
    };
    
      @override
      // TODO: implement props
      List<Object?> get props => [];
}
