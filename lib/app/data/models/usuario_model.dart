//Clase para el usuario
import 'package:equatable/equatable.dart';

class UsuarioModel extends Equatable {
  final String? uid;

  final String? cedula;
  final String nombre;
  final String apellido;
  final String correo;
  final String contrasena;
  final String? perfil;

  const UsuarioModel(this.nombre, this.apellido, this.correo, this.contrasena,
      {this.uid, this.cedula, this.perfil});

  Map<String, Object?> toFirebaseMap({String? cedula}) {
    return <String, Object?>{
      'id': uid,
      'nombre': nombre,
      'apellido': apellido,
      'cedula': cedula,
    };
  }

  UsuarioModel.fromFirebaseMap(Map<String, Object?> data)
      : uid = '',
        nombre = '',
        apellido = '',
        correo = data['correo'] as String,
        contrasena = '',
        cedula = data['cedula'] as String,
        perfil = data['perfil'] as String;

  @override
  List<Object?> get props => [uid, nombre, apellido, cedula, perfil];
}
