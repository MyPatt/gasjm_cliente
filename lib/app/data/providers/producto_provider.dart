
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/producto_model.dart';

class ProductoProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;

  //

  Future<void> insertProducto({required ProductoModel producto}) async {
    await _firestoreInstance.collection('producto').add(producto.toMap());
  }

  //
  Future<void> updateProducto({required ProductoModel producto}) async {
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
  Future<List<ProductoModel>?> getProductos() async {
    final snapshot = await _firestoreInstance.collection('producto').get();

    if (snapshot.docs.isNotEmpty) {
      return (snapshot.docs)
          .map((item) => ProductoModel.fromMap(item.data()))
          .toList();
    }
    return null;
  }

  //
  Future<ProductoModel?> getProductoPorId({required String id}) async {
    final snapshot = await _firestoreInstance
        .collection("producto")
        .where("idProducto", isEqualTo: id)
        .get();
    if (snapshot.docs.first.exists) {
      return ProductoModel.fromMap(snapshot.docs.first.data());
    }
    return null;
  }

  //
  Future<double> getPrecioPorProducto({required String id}) async {
    final snapshot = await _firestoreInstance
        .collection("producto")
        .where("idProducto", isEqualTo: id)
        .get();
    double producto = 0;
    if (snapshot.docs.first.exists) {
    producto=  ProductoModel.fromMap(snapshot.docs.first.data()).precioProducto;

     
    }
    
    return producto;
  }
}
