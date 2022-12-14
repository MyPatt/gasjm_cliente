import 'package:gasjm/app/data/models/pedido_model.dart';

class PersonaModel {
  PersonaModel({this.uidPersona,
      required this.cedulaPersona,
      required this.nombrePersona,
      required this.apellidoPersona,
      this.correoPersona,
      this.fotoPersona,
      this.direccionPersona,
      this.celularPersona,
      this.fechaNaciPersona,
      this.estadoPersona,
      required this.idPerfil,
      required this.contrasenaPersona});

  final String? uidPersona;
  final String cedulaPersona;
  final String nombrePersona;
  final String apellidoPersona;
  final String? correoPersona;
  final String? fotoPersona;
  final Direccion? direccionPersona;
  final String? celularPersona;
  final String? fechaNaciPersona;
  final String idPerfil;
  final String? estadoPersona;
  final String contrasenaPersona;

  factory PersonaModel.fromMap(Map<String, dynamic> json) => PersonaModel(
 uidPersona: json["uid"],
        cedulaPersona: json["cedula"],
        nombrePersona: json["nombre"],
        apellidoPersona: json["apellido"],
        correoPersona: json["correo"],
        fotoPersona: json["foto"],
        direccionPersona: Direccion.fromMap(json["direccion"]),
        celularPersona: json["celular"],
        fechaNaciPersona: json["fechaNacimiento"],
        estadoPersona: json["estado"],
        idPerfil: json["idPerfil"],
        contrasenaPersona: json['contrasena'],
      );

  Map<String, dynamic> toMap() => {
     "uid":uidPersona,
        "cedula": cedulaPersona,
        "nombre": nombrePersona,
        "apellido": apellidoPersona,
        "correo": correoPersona,
        "foto": fotoPersona,
        "direccion": direccionPersona?.toMap(),
        "celular": celularPersona,
        "fechaNacimiento": fechaNaciPersona,
        "estado": estadoPersona,
        "idPerfil": idPerfil,
        "contrasena": '.....'
      };
}
