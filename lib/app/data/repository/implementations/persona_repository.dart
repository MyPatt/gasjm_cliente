import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/providers/persona_provider.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:get/get.dart';

class PersonaRepositoryImpl extends PersonaRepository {
  final _provider = Get.find<PersonaProvider>();
  @override
  Future<void> deletePersona({required String persona}) =>
      _provider.deletePersona(persona: persona);

  @override
  Future<PersonaModel?> getPersonaPorCedula({required String cedula}) =>
      _provider.getPersonaPorCedula(cedula: cedula);

  @override
  Future<List<PersonaModel>?> getPersonaPorField(
          {required String field, required String dato}) =>
      _provider.getPersonaPorField(field: field, dato: dato);

  @override
  Future<List<PersonaModel>?> getPersonas() => _provider.getPersonas();

  @override
  Future<void> insertPersona({required PersonaModel persona}) =>
      _provider.insertPersona(persona: persona);

  @override
  Future<void> updatePersona({required PersonaModel persona}) =>
      _provider.updatePersona(persona: persona);

  @override
  Future<String?> getNombresPersonaPorCedula({required String cedula}) =>
      _provider.getNombresPersonaPorCedula(cedula: cedula);
}
