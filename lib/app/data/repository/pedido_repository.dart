import 'package:gasjm/app/data/models/pedido_model.dart';

abstract class PedidoRepository {
  Future<void> insertPedido({required PedidoModel pedidoModel});
  Future<void> updatePedido({required PedidoModel pedidoModel});
  Future<void> deletePedido({required String pedido});
  Future<List<PedidoModel>?> getPedidos();
  Future<List<PedidoModel>?> getPedidoPorField(
      {required String field, required String dato});
}
