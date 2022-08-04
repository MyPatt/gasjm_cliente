import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';

class PedidoProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance; 

  //
  Future<void> insertPedido({required PedidoModel pedidoModel}) async {
    await _firestoreInstance.collection('pedido').add(pedidoModel.toJson());
  }
  //

  Future<void> updatePedido({required PedidoModel pedidoModel}) async {
    await _firestoreInstance
        .collection('pedido')
        .doc(pedidoModel.idPedido)
        .update(pedidoModel.toJson());
  }

  //
  Future<void> deletePedido({required String pedido}) async {
    await _firestoreInstance.collection('pedido').doc(pedido).delete();
  }

  //
  Future<List<PedidoModel>?> getPedidos() async {
    final resultado = await _firestoreInstance.collection('pedido').get();

    return (resultado.docs)
        .map((item) => PedidoModel.fromJson(item.data()))
        .toList();
  }

  Future<PedidoModel?> getPedidoPorUid({required String uid}) async {
    final resultado =
        await _firestoreInstance.collection('pedido').doc(uid).get();
    if ((resultado.exists)) {
      return PedidoModel.fromJson(resultado.data()!);
    }
    return null;
  }

  Future<List<PedidoModel>?> getPedidoPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("pedido")
        .where(field, isEqualTo: dato)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return (resultado.docs)
          .map((item) => PedidoModel.fromJson(item.data()))
          .toList();
    }
    return null;
  }
}
