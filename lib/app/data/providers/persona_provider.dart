import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasjm/app/data/models/persona_model.dart';

class PersonaProvider {
  //Instancia de firestore bd
  final _firestoreInstance = FirebaseFirestore.instance;
  //Instancia de storage para almacena las imagenes de perfil
  FirebaseStorage get _storageInstance => FirebaseStorage.instance;

  //Par devolver el usuario actual conectado
  User get usuarioActual {
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario == null) throw Exception('Excepción no autenticada');
    return usuario;
  }

  Future<void> insertPersona({required PersonaModel persona}) async {
    await _firestoreInstance.collection('persona').add(persona.toMap());
  }

//Metodo para actualizar los datos de una persona incluido su foto de perfil
  Future<void> updatePersona(
      {required PersonaModel persona, File? image}) async {
    await _firestoreInstance
        .collection('persona')
        .doc(persona.uidPersona)
        .update(persona.toMap());
    if (image != null) {
      final imagePath =
          '${usuarioActual.uid}/perfil/fotoperfil${path.extension(image.path)}';
      final storageRef = _storageInstance.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      _firestoreInstance
          .collection("persona")
          .doc(usuarioActual.uid)
          .update({"foto": url});
    }
  }

  //Actualiza la contrasena del usuario
  Future<bool> updateContrasenaPersona(
      {required String uid,
      required String actualContrasena,
      required String nuevaContrasena}) async {
    bool actualizado = false;
    //

    final credencial = EmailAuthProvider.credential(
        email: usuarioActual.email.toString(), password: actualContrasena);
    await usuarioActual.reauthenticateWithCredential(credencial).then((value) {
      usuarioActual.updatePassword(nuevaContrasena).then((value) {
        actualizado = true;
      });
    });

    return actualizado;
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
        .where("cedula", isEqualTo: cedula)
        .get();
    if (snapshot.docs.isNotEmpty) {
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

  //Obtner perfil del usuario actual
  Future<PersonaModel?> getUsuarioActual() async {
    final snapshot = await _firestoreInstance
        .collection('persona')
        .doc(usuarioActual.uid)
        .get();
    if (snapshot.exists) {
      return PersonaModel.fromMap(snapshot.data()!);
    }
    return null;
  }

  //Retorna datos personales publicos de la persona
  Future<String?> getDatoPersonaPorField(
      {required String field,
      required String dato,
      required String getField}) async {
    final resultado = await _firestoreInstance
        .collection("persona")
        .where(field, isEqualTo: dato)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      String dato = resultado.docs.first.get(getField).toString();
      return dato;
    }
    return null;
  }

    Future<String?> getImagenUsuarioActual() async {
    final snapshot =await  _firestoreInstance
        .collection('persona')
        .doc(usuarioActual.uid)
        .get();
            
    String? resultado=(snapshot.get("foto"));
   
    if (resultado!=null) {  
      return resultado;
    }
    return null;
  }

}
