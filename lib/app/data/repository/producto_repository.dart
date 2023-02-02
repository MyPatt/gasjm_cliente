import 'package:gasjm/app/data/models/producto_model.dart';

abstract class ProductoRepository {
  Future<ProductoModel?> getProductoPorId(String id);
  Future<double> getPrecioPorProducto({required String id});
}
