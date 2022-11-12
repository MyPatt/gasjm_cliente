import 'package:equatable/equatable.dart';
import 'package:gasjm/app/data/models/persona_model.dart'; 

//Repositorio con 2 clases -para autenticar usuario
//Abstraer el usuario de firebase para obtener el uid
class AutenticacionUsuario extends Equatable {
  final String uid;
  final String? nombre;
  final String? perfil;

  const AutenticacionUsuario(this.uid, this.nombre, this.perfil);

  @override
  List<Object?> get props => [uid, nombre, perfil];
}

//Clase abstracta
abstract class AutenticacionRepository {
  AutenticacionUsuario? get autenticacionUsuario;

  //escucha el cambio de estado de autenticacion (login o no)
  Stream<AutenticacionUsuario?> get enEstadDeAutenticacionCambiado;

//Iniciar sesion con correo y contrasena
  Future<AutenticacionUsuario?> iniciarSesionConCorreoYContrasena(
      String correo, String contrasena);

//Crear usuario  con correo y contrasena booo
  Future<AutenticacionUsuario?> crearUsuarioConCorreoYContrasena(
      String correo, String contrasena);

  //Crear usuario  con datos
  Future<AutenticacionUsuario?> registrarUsuario(PersonaModel usuario);

//Cerrar sesion
  Future<void> cerrarSesion();
}
