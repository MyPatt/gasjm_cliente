import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/estadopedido_model.dart';

class EstadoPedidoProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;

  //

  Future<void> insertEstadoPedido(
      {required EstadoPedidoModel estadopedido}) async {
    await _firestoreInstance
        .collection('estadopedido')
        .add(estadopedido.toMap());
  }

  //
  Future<void> updateEstadoPedido(
      {required EstadoPedidoModel estadopedido}) async {
    await _firestoreInstance
        .collection('estadopedido')
        .doc(estadopedido.idEstadoPedido)
        .update(estadopedido.toMap());
  }

  //
  Future<void> deleteEstadoPedido({required String estadopedido}) async {
    await _firestoreInstance
        .collection('estadopedido')
        .doc(estadopedido)
        .delete();
  }

  //
  Future<List<EstadoPedidoModel>?> getEstadosPedido() async {
    final snapshot = await _firestoreInstance.collection('estadopedido').get();

    if (snapshot.docs.isNotEmpty) {
      return (snapshot.docs)
          .map((item) => EstadoPedidoModel.fromMap(item.data()))
          .toList();
    }
    return null;
  }

  //
  Future<EstadoPedidoModel?> getEstadoPedidoPorId({required String id}) async {
    final snapshot = await _firestoreInstance
        .collection("estadopedido")
        .where("idEstadoPedido", isEqualTo: id)
        .get();
    if (snapshot.docs.first.exists) {
      return EstadoPedidoModel.fromMap(snapshot.docs.first.data());
    }
    return null;
  }

  Future<List<EstadoPedidoModel>?> getEstadoPedidoPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("estadopedido")
        .where(field, isEqualTo: dato)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return (resultado.docs)
          .map((item) => EstadoPedidoModel.fromMap(item.data()))
          .toList();
    }
    return null;
  }
}
