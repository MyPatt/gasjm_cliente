import 'package:gasjm/app/data/models/producto_model.dart';
import 'package:gasjm/app/data/providers/producto_provider.dart';
import 'package:gasjm/app/data/repository/producto_repository.dart';
import 'package:get/get.dart';

class ProductoRepositoryImpl extends ProductoRepository {
  final _provider = Get.find<ProductoProvider>();

  @override
  Future<ProductoModel?> getProductoPorId(String id) =>
      _provider.getProductoPorId(id: id);

  @override
  Future<double> getPrecioPorProducto({required String id}) =>
      _provider.getPrecioPorProducto(id: id);
}
