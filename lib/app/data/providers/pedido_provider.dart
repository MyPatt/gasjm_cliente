import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';

class PedidoProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;  
 final usuario = FirebaseAuth.instance.currentUser; 
  //
  Future<void> insertPedido({required PedidoModel pedidoModel}) async {
    final resultado =
        await _firestoreInstance.collection('pedido').add(pedidoModel.toJson());
    await _firestoreInstance
        .collection("pedido")
        .doc(resultado.id)
        .update({"idPedido": resultado.id});
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

  Future<List<PedidoModel>?> getListaPedidosPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("pedido")
        .where(field, isEqualTo: dato)
        .orderBy("fechaHoraPedido", descending: true)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return (resultado.docs)
          .map((item) => PedidoModel.fromJson(item.data()))
          .toList();
    }
    return null;
  }

  //
  Future<PedidoModel?> getPedidoPorField(
      {required String field, required String dato}) async {
    final resultado = await _firestoreInstance
        .collection("pedido")
        .where(field, isEqualTo: dato).orderBy("fechaHoraPedido",descending: true)
        .limit(1)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return PedidoModel.fromJson(resultado.docs.first.data());
      /*(resultado.docs)
          .map((item) => PedidoModel.fromJson(item.data()))
          .toList();*/
    }
    return null;
  }

  //
  Future<List<PedidoModel>?> getPedidosPorDosQueries({
    required String field1,
    required String dato1,
    required String field2,
    required String dato2,
  }) async {
    final resultado = await _firestoreInstance
        .collection("pedido")
        .where(field1, isEqualTo: dato1)
        .where(field2, isEqualTo: dato2)
        .get();
    if ((resultado.docs.isNotEmpty)) {
      return (resultado.docs)
          .map((item) => PedidoModel.fromJson(item.data()))
          .toList();
    }
    return null;
  }

  //
  Future<String?> getDescripcionEstadoPedido({required String idEstado}) async {
    final snapshot = await _firestoreInstance
        .collection('estadopedido')
        .where("idEstadoPedido", isEqualTo: idEstado)
        .limit(1)
        .get();
    return snapshot.docs.first.get("descripcionEstadoPedido").toString();
  }

  Future<String?> getNombreEstadoPedidoPorId({required String idEstado}) async {
    final snapshot = await _firestoreInstance
        .collection('estadopedido')
        .where("idEstadoPedido", isEqualTo: idEstado)
        .limit(1)
        .get();
    return snapshot.docs.first.get("nombreEstadoPedido").toString();
  }

  //Obtener los cambios de los estados
  Future<EstadoDelPedido?> getEstadoPedidoPorField({
    required String uid,
    required String field,
  }) async {
    final resultado =
        await _firestoreInstance.collection("pedido").doc(uid).get();
    var datos = (resultado.get(field));


    if ((datos != null)) {
      return EstadoDelPedido.fromJson(resultado.get(field));
    } else {
      return null;
    }
  }

    //

  Future<void> updateEstadoPedido(
      {required String idPedido, required String estadoPedido,required String numeroEstadoPedido }) async {
    await _firestoreInstance
        .collection('pedido')
        .doc(idPedido)
        .update({"idEstadoPedido": estadoPedido,
        
        numeroEstadoPedido:EstadoDelPedido(idEstado: estadoPedido  , fechaHoraEstado: Timestamp.now(), idPersona: usuario!.uid).toMap()
 });
  }

}
