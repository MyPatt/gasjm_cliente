 
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
  Future<ProductoModel?> getProductoPorId(String id) =>
      _provider.getProductoPorId(id: id);

  @override
        Future<double> getPrecioPorProducto({required String id}) =>
      _provider.getPrecioPorProducto(id: id);
  

  @override
  Future<List<ProductoModel>?> getProductos() => _provider.getProductos();

  @override
  Future<void> insertProducto({required ProductoModel producto}) =>
      _provider.insertProducto(producto: producto);

  @override
  Future<void> updateProducto({required ProductoModel producto}) =>
      _provider.updateProducto(producto: producto);

 

}
