import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/ubicacionrepartidor_model.dart';

class UbicacionRepartidorProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;

  //
  Future<void> insertUbicacionRepartidor(
      {required UbicacionRepartidorModel ubicacionRepartidorModel}) async {
    final resultado = await _firestoreInstance
        .collection('ubicacionRepartidor')
        .add(ubicacionRepartidorModel.toMap());
    await _firestoreInstance
        .collection("ubicacionRepartidor")
        .doc(resultado.id)
        .update({"idUbicacionRepartidor": resultado.id});
  }
  //

  Future<void> updateUbicacionRepartidor(
      {required UbicacionRepartidorModel ubicacionRepartidorModel}) async {
    await _firestoreInstance
        .collection('ubicacionRepartidor')
        .doc(ubicacionRepartidorModel.idUbicacionRepartidor)
        .update(ubicacionRepartidorModel.toMap());
  }

  //
  Future<void> deleteUbicacionRepartidor(
      {required String idUbicacionRepartidor}) async {
    await _firestoreInstance
        .collection('ubicacionRepartidor')
        .doc(idUbicacionRepartidor)
        .delete();
  }

  //
  Future<List<UbicacionRepartidorModel>?> getUbicacionRepartidor() async {
    final resultado =
        await _firestoreInstance.collection('ubicacionRepartidor').get();

    return (resultado.docs)
        .map((item) => UbicacionRepartidorModel.fromMap(item.data()))
        .toList();
  }

  Future<UbicacionRepartidorModel?> getUbicacionRepartidorPorUid(
      {required String uid}) async {
    final resultado = await _firestoreInstance
        .collection('ubicacionRepartidor')
        .doc(uid)
        .get();
    if ((resultado.exists)) {
      return UbicacionRepartidorModel.fromMap(resultado.data()!);
    }
    return null;
  }

  Future<List<UbicacionRepartidorModel>?> getUbicacionRepartidorPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("ubicacionRepartidor")
        .where(field, isEqualTo: dato)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return (resultado.docs)
          .map((item) => UbicacionRepartidorModel.fromMap(item.data()))
          .toList();
    }
    return null;
  }
}
