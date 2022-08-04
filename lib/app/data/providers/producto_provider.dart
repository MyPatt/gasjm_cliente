import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/producto_model.dart';

class ProductoProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;

  //

  Future<void> insertProducto({required Producto producto}) async {
    await _firestoreInstance.collection('producto').add(producto.toMap());
  }

  //
  Future<void> updateProducto({required Producto producto}) async {
    await _firestoreInstance
        .collection('producto')
        .doc(producto.idProducto)
        .update(producto.toMap());
  }

  //
  Future<void> deleteProducto({required String producto}) async {
    await _firestoreInstance.collection('producto').doc(producto).delete();
  }

  //
  Future<List<Producto>?> getProductos() async {
    final snapshot = await _firestoreInstance.collection('producto').get();

    if (snapshot.docs.isNotEmpty) {
      return (snapshot.docs)
          .map((item) => Producto.fromMap(item.data()))
          .toList();
    }
    return null;
  }

  //
  Future<Producto?> getProductoPorId({required String id}) async {
    final snapshot = await _firestoreInstance
        .collection("producto")
        .where("idProducto", isEqualTo: id)
        .get();
    if (snapshot.docs.first.exists) {
      return Producto.fromMap(snapshot.docs.first.data());
    }
    return null;
  }
}
