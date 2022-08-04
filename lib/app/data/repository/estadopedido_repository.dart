import 'package:gasjm/app/data/models/estadopedido_model.dart';

abstract class EstadoPedidoRepository {
  Future<void> insertEstadoPedido({required EstadoPedidoModel estadopedido});
  Future<void> updateEstadoPedido({required EstadoPedidoModel estadopedido});
  Future<void> deleteEstadoPedido({required String estadopedido});
  Future<EstadoPedidoModel?> getEstadoPedidoPorId({required String id});
  Future<List<EstadoPedidoModel>?> getEstadoPedidoPorField(
      {required String field, required String dato});

  Future<List<EstadoPedidoModel>?> getEstadosPedido();
}
