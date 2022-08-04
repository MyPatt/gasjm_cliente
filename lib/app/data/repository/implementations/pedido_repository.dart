import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/providers/pedido_provider.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:get/get.dart';

class PedidoRepositoryImpl extends PedidoRepository {
  final _provider = Get.find<PedidoProvider>();

  @override
  Future<List<PedidoModel>?> getPedidos() => _provider.getPedidos();

  @override
  Future<void> insertPedido({required PedidoModel pedidoModel}) =>
      _provider.insertPedido(pedidoModel: pedidoModel);

  @override
  Future<void> deletePedido({required String pedido}) =>
      _provider.deletePedido(pedido: pedido);

  @override
  Future<List<PedidoModel>?> getPedidoPorField(
          {required String field, required String dato}) =>
      _provider.getPedidoPorField(field: field, dato: dato);

  @override
  Future<void> updatePedido({required PedidoModel pedidoModel}) =>
      _provider.updatePedido(pedidoModel: pedidoModel);
}
