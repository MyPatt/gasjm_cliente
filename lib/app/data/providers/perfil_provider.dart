import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/perfil_model.dart';

class PerfilProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;

  //

  Future<void> insertPerfil({required PerfilModel perfil}) async {
    await _firestoreInstance.collection('perfil').add(perfil.toMap());
  }

  //
  Future<void> updatePerfil({required PerfilModel perfil}) async {
    await _firestoreInstance
        .collection('perfil')
        .doc(perfil.idPerfil)
        .update(perfil.toMap());
  }

  //
  Future<void> deletePerfil({required String perfil}) async {
    await _firestoreInstance.collection('perfil').doc(perfil).delete();
  }

  //
  Future<List<PerfilModel>?> getPerfiles() async {
    final snapshot = await _firestoreInstance.collection('perfil').get();

    if (snapshot.docs.isNotEmpty) {
      return (snapshot.docs)
          .map((item) => PerfilModel.fromMap(item.data()))
          .toList();
    }
    return null;
  }

  //
  Future<PerfilModel?> getPerfilPorId({required String id}) async {
    final snapshot = await _firestoreInstance
        .collection("perfil")
        .where("idPerfil", isEqualTo: id)
        .get();
    if (snapshot.docs.first.exists) {
      return PerfilModel.fromMap(snapshot.docs.first.data());
    }
    return null;
  }

  
    Future<List<PerfilModel>?> getPerfilPorField({required String field,required String dato}) async {
    final resultado =
        await _firestoreInstance. collection("perfil")
        .where(field, isEqualTo: dato)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return  (resultado.docs)
        .map((item) => PerfilModel.fromMap(item.data()))
        .toList();
    }
    return null;
  }
}
