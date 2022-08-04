import 'package:gasjm/app/data/models/persona_model.dart';

abstract class PersonaRepository {
  Future<void> insertPersona({required PersonaModel persona});
  Future<void> updatePersona({required PersonaModel persona});
  Future<void> deletePersona({required String persona});
  Future<PersonaModel?> getPersonaPorCedula({required String cedula});
  Future<String?> getNombresPersonaPorCedula({required String cedula});
  Future<List<PersonaModel>?> getPersonaPorField(
      {required String field, required String dato});

  Future<List<PersonaModel>?> getPersonas();
}
