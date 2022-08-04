import 'package:gasjm/app/data/models/usuario_model.dart';

abstract class MyUserRepository {
  Future<UsuarioModel?> getUsuario();
  Future<UsuarioModel?> getUsuarioPorCedula(String cedula);
  Future<UsuarioModel?> getPerfilUsuarioPorUid({required String uid});
}
