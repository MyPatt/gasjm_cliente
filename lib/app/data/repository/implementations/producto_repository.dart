import 'package:gasjm/app/data/models/producto_model.dart';
import 'package:gasjm/app/data/providers/producto_provider.dart';
import 'package:gasjm/app/data/repository/producto_repository.dart';
import 'package:get/get.dart';

class ProductoRepositoryImpl extends ProductoRepository {
  final _provider = Get.find<ProductoProvider>();
  @override
  Future<void> deleteProducto({required String producto}) =>
      _provider.deleteProducto(producto: producto);

  @override
  Future<Producto?> getProductoPorId(String id) =>
      _provider.getProductoPorId(id: id);

  @override
  Future<List<Producto>?> getProductos() => _provider.getProductos();

  @override
  Future<void> insertProducto({required Producto producto}) =>
      _provider.insertProducto(producto: producto);

  @override
  Future<void> updateProducto({required Producto producto}) =>
      _provider.updateProducto(producto: producto);
}
