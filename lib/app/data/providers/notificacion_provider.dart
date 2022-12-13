import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasjm/app/data/models/notificacion_model.dart';

class NotificacionProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;
  final _usuario = FirebaseAuth.instance.currentUser;
  //
  Timestamp fechaHoraActual = Timestamp.now();
  //
  Future<void> insertNotificacion(
      {required Notificacion notificacionModel}) async {
    final resultado = await _firestoreInstance
        .collection('notificacion')
        .add(notificacionModel.toMap());
    await _firestoreInstance
        .collection("notificacion")
        .doc(resultado.id)
        .update({"idNotificacion": resultado.id});
  }

//
  Future<List<Notificacion>?> getNotificaciones() async {
    final resultado = await _firestoreInstance
        .collection('notificacion')
        .where("idEmisorNotificacion", isEqualTo: _usuario!.uid)
        .orderBy("fechaNotificacion", descending: true)
        .get();
    //. limit(5);
    if (resultado.docs.isEmpty) {
      return [];
    } else {
      return (resultado.docs.map((item) => Notificacion.fromMap(item.data())))
          .toList();
    }
  }
}
