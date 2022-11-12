 
import 'package:gasjm/app/data/models/producto_model.dart';

abstract class ProductoRepository {
  Future<void> insertProducto({required ProductoModel producto});
  Future<void> updateProducto({required ProductoModel producto});
  Future<void> deleteProducto({required String producto});
  Future<List<ProductoModel>?> getProductos();
  Future<ProductoModel?> getProductoPorId(String id);
  Future<double> getPrecioPorProducto({required String id});
}
