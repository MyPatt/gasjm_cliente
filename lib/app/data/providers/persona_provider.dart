import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/persona_model.dart';

class PersonaProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;

  //

  Future<void> insertPersona({required PersonaModel persona}) async {
    await _firestoreInstance.collection('persona').add(persona.toMap());
  }

  //
  Future<void> updatePersona({required PersonaModel persona}) async {
    await _firestoreInstance
        .collection('persona')
        .doc(persona.cedulaPersona)
        .update(persona.toMap());
  }

  //
  Future<void> deletePersona({required String persona}) async {
    await _firestoreInstance.collection('persona').doc(persona).delete();
  }

  //
  Future<List<PersonaModel>?> getPersonas() async {
    final snapshot = await _firestoreInstance.collection('persona').get();

    if (snapshot.docs.isNotEmpty) {
      return (snapshot.docs)
          .map((item) => PersonaModel.fromMap(item.data()))
          .toList();
    }
    return null;
  }

  //
  Future<PersonaModel?> getPersonaPorCedula({required String cedula}) async {
    final snapshot = await _firestoreInstance
        .collection("persona")
        .where("cedulaPersona", isEqualTo: cedula)
        .get();
    if (snapshot.docs.first.exists) {
      return PersonaModel.fromMap(snapshot.docs.first.data());
    }
    return null;
  }

  Future<List<PersonaModel>?> getPersonaPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("persona")
        .where(field, isEqualTo: dato)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return (resultado.docs)
          .map((item) => PersonaModel.fromMap(item.data()))
          .toList();
    }
    return null;
  }

  Future<String?> getNombresPersonaPorCedula({required String cedula}) async {
    final resultado = await _firestoreInstance
        .collection("persona")
        .where("cedula", isEqualTo: cedula)
        .get();

    if (resultado.docs.isNotEmpty) {
      final nombres =
          '${resultado.docs.first.get("nombre")} ${resultado.docs.first.get("apellido")} ';
      return nombres;
    }
    return null;
  }
}
