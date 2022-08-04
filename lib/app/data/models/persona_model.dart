class PersonaModel {
  PersonaModel({
    required this.cedulaPersona,
    required this.nombrePersona,
    required this.apellidoPersona,
    required this.fotoPersona,
    required this.direccionPersona,
    required this.celularPersona,
    required this.fechaNaciPersona,
    required this.idPerfil,
  });

  final String cedulaPersona;
  final String nombrePersona;
  final String apellidoPersona;
  final String? fotoPersona;
  final String? direccionPersona;
  final String? celularPersona;
  final DateTime fechaNaciPersona;
  final String idPerfil;

  factory PersonaModel.fromMap(Map<String, dynamic> json) => PersonaModel(
        cedulaPersona: json["cedula"],
        nombrePersona: json["nombre"],
        apellidoPersona: json["apellido"],
        fotoPersona: json["foto"],
        direccionPersona: json["direccion"],
        celularPersona: json["celular"],
        fechaNaciPersona: json["fechaNacimiento"],
        idPerfil: json["idPerfil"],
      );

  Map<String, dynamic> toMap() => {
        "cedula": cedulaPersona,
        "nombre": nombrePersona,
        "apellido": apellidoPersona,
        "foto": fotoPersona,
        "direccion": direccionPersona,
        "celular": celularPersona,
        "fechaNacimiento": fechaNaciPersona,
        "idPerfil": idPerfil,
      };
}
