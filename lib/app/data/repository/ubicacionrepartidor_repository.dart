
import 'package:gasjm/app/data/models/ubicacionrepartidor_model.dart';

abstract class UbicacionRepartidorRepository {
  Future<void> insertUbicacionRepartidor({required UbicacionRepartidorModel ubicacionRepartidorModel});
  Future<void> updateUbicacionRepartidor({required UbicacionRepartidorModel ubicacionRepartidorModel});
  Future<void> deleteUbicacionRepartidor({required String idUbicacionRepartidor});
  Future<List<UbicacionRepartidorModel>?> getUbicacionRepartidor();
  Future<List<UbicacionRepartidorModel>?> getUbicacionRepartidorPorField(
      {required String field, required String dato});
}
