import 'package:gasjm/app/data/models/perfil_model.dart';

abstract class PerfilRepository {
  Future<void> insertPerfil({required PerfilModel perfil});
  Future<void> updatePerfil({required PerfilModel perfil});
  Future<void> deletePerfil({required String perfil});
  Future<List<PerfilModel>?> getPerfiles();
  Future<PerfilModel?> getPerfilPorId({required String id});
  Future<List<PerfilModel>?> getPerfilPorField(
      {required String field, required String dato});
}
