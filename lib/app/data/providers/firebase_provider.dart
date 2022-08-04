import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';

class FirebaseProvider {
  //Par devolver el usuario actual conectado
  User get usuarioActual {
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario == null) throw Exception('Excepción no autenticada');
    return usuario;
  }

  //Instancia de firestore
  //FirebaseFirestore get firestore => FirebaseFirestore.instance;

  //Instancia de firestore
  final firestoreInstance = FirebaseFirestore.instance;

  //Obtner perfil del usuario actual
  Future<UsuarioModel?> getUsuarioActual() async {
    final snapshot = await firestoreInstance
        .collection('usuarios')
        .doc(usuarioActual.uid)
        .get();
    if (snapshot.exists) {
      return UsuarioModel.fromFirebaseMap(snapshot.data()!);
    }
    return null;
  }

  //
  Future<UsuarioModel?> getUsuarioPorCedula(String cedula) async {
    var result = await firestoreInstance
        .collection("usuarios")
        .where("cedula", isEqualTo: cedula)
        .get();
    if (result.docs.isNotEmpty) {
      return UsuarioModel.fromFirebaseMap(result.docs.first.data());
    } else {
      return null;
    }
  }

//
  Future<UsuarioModel?> getPerfilDeUsuario({required String uid}) async {
    final resultado =
        await firestoreInstance.collection("usuarios").doc(uid).get();

    if ((resultado.exists)) {
    
      return UsuarioModel.fromFirebaseMap(resultado.data()!);
    }
    return null;
  }
}
