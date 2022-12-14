import 'dart:io';

import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/providers/persona_provider.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:get/get.dart';

class PersonaRepositoryImpl extends PersonaRepository {
  final _provider = Get.find<PersonaProvider>();
    @override
  DateTime get fechaHoraActual => _provider.fechaHoraActual.toDate();

  @override
  String get idUsuarioActual => _provider.idUsuarioActual;
  @override
  String get nombreUsuarioActual => _provider.nombreUsuarioActual;

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
  Future<String?> getDatoPersonaPorField(
          {required String field,
          required String dato,
          required String getField}) =>
      _provider.getDatoPersonaPorField(
          field: field, dato: dato, getField: getField);

  @override
  Future<List<PersonaModel>?> getPersonas() => _provider.getPersonas();
  @override
  Future<String?> getImagenUsuarioActual() =>
      _provider.getImagenUsuarioActual();

  @override
  Future<void> insertPersona({required PersonaModel persona}) =>
      _provider.insertPersona(persona: persona);

  @override
  Future<void> updatePersona({required PersonaModel persona, File? image}) =>
      _provider.updatePersona(persona: persona, image: image);
  @override
  Future<bool> updateContrasenaPersona(
          {required String uid,
          required String actualContrasena,
          required String nuevaContrasena}) =>
      _provider.updateContrasenaPersona(
          uid: uid,
          actualContrasena: actualContrasena,
          nuevaContrasena: nuevaContrasena);

  @override
  Future<String?> getNombresPersonaPorCedula({required String cedula}) =>
      _provider.getNombresPersonaPorCedula(cedula: cedula);

  @override
  Future<PersonaModel?> getUsuario() => _provider.getUsuarioActual();
  @override
  Future<String?> getNombresPersonaPorUid({required String uid})=>_provider.getNombresPersonaPorUid(uid: uid);
}
