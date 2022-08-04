import 'package:gasjm/app/data/models/perfil_model.dart';
import 'package:gasjm/app/data/providers/perfil_provider.dart';
import 'package:gasjm/app/data/repository/perfil_repository.dart';
import 'package:get/get.dart';

class PerfilRepositoryImpl extends PerfilRepository {
  final _provider = Get.find<PerfilProvider>();
  @override
  Future<void> deletePerfil({required String perfil}) =>
      _provider.deletePerfil(perfil: perfil);

  @override
  Future<List<PerfilModel>?> getPerfilPorField(
          {required String field, required String dato}) =>
      _provider.getPerfilPorField(field: field, dato: dato);

  @override
  Future<PerfilModel?> getPerfilPorId({required String id}) =>
      _provider.getPerfilPorId(id: id);

  @override
  Future<List<PerfilModel>?> getPerfiles() => _provider.getPerfiles();

  @override
  Future<void> insertPerfil({required PerfilModel perfil}) =>
      _provider.insertPerfil(perfil: perfil);

  @override
  Future<void> updatePerfil({required PerfilModel perfil}) =>
      _provider.updatePerfil(perfil: perfil);
}
