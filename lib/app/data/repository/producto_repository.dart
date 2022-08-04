import 'package:gasjm/app/data/models/producto_model.dart';

abstract class ProductoRepository {
  Future<void> insertProducto({required Producto producto});
  Future<void> updateProducto({required Producto producto});
  Future<void> deleteProducto({required String producto});
  Future<List<Producto>?> getProductos();
  Future<Producto?> getProductoPorId(String id);
}
