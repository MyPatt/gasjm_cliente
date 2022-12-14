import 'dart:io';

import 'package:gasjm/app/data/models/persona_model.dart';

abstract class PersonaRepository {
    DateTime get fechaHoraActual;
  String get idUsuarioActual;
  String get nombreUsuarioActual;
  Future<void> insertPersona({required PersonaModel persona});
  Future<void> updatePersona({required PersonaModel persona, File? image});
  Future<bool> updateContrasenaPersona(
      {required String uid,
      required String actualContrasena,
      required String nuevaContrasena});
  Future<void> deletePersona({required String persona});
  Future<PersonaModel?> getPersonaPorCedula({required String cedula});
  Future<String?> getNombresPersonaPorCedula({required String cedula});
  Future<List<PersonaModel>?> getPersonaPorField(
      {required String field, required String dato});

  Future<List<PersonaModel>?> getPersonas();
  Future<PersonaModel?> getUsuario();

  Future<String?> getDatoPersonaPorField(
      {required String field, required String dato, required String getField});
  Future<String?> getImagenUsuarioActual();
  Future<String?> getNombresPersonaPorUid({required String uid});
}
