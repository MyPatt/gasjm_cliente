 
import 'package:gasjm/app/data/models/ubicacionrepartidor_model.dart';
import 'package:gasjm/app/data/providers/ubicacionrepartidor_provider.dart';
import 'package:gasjm/app/data/repository/ubicacionrepartidor_repository.dart';
import 'package:get/get.dart';

class UbicacionRepartidorImpl extends UbicacionRepartidorRepository {
  final _provider = Get.find<UbicacionRepartidorProvider>();

  @override
  Future<void> deleteUbicacionRepartidor(
          {required String idUbicacionRepartidor}) =>
      _provider.deleteUbicacionRepartidor(
          idUbicacionRepartidor: idUbicacionRepartidor);

  @override
  Future<List<UbicacionRepartidorModel>?> getUbicacionRepartidor() =>
      _provider.getUbicacionRepartidor();

  @override
  Future<List<UbicacionRepartidorModel>?> getUbicacionRepartidorPorField(
          {required String field, required String dato}) =>
      _provider.getUbicacionRepartidorPorField(field: field, dato: dato);

  @override
  Future<void> insertUbicacionRepartidor(
          {required UbicacionRepartidorModel ubicacionRepartidorModel}) =>
      _provider.insertUbicacionRepartidor(
          ubicacionRepartidorModel: ubicacionRepartidorModel);

  @override
  Future<void> updateUbicacionRepartidor(
          {required UbicacionRepartidorModel ubicacionRepartidorModel}) =>
      _provider.updateUbicacionRepartidor(
          ubicacionRepartidorModel: ubicacionRepartidorModel);
}
