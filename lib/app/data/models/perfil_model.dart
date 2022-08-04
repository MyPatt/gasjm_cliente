 

class PerfilModel {
    PerfilModel({
        required this.idPerfil,
        required this.nombrePerfil,
        required this.descripcionPerfil,
    });

    final String idPerfil;
    final String nombrePerfil;
    final String descripcionPerfil;
 

    factory PerfilModel.fromMap(Map<String, dynamic> json) => PerfilModel(
        idPerfil: json["idPerfil"],
        nombrePerfil: json["nombrePerfil"],
        descripcionPerfil: json["descripcionPerfil"],
    );

    Map<String, dynamic> toMap() => {
        "idPerfil": idPerfil,
        "nombrePerfil": nombrePerfil,
        "descripcionPerfil": descripcionPerfil,
    };
}