import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/providers/estadopedido_provider.dart';
import 'package:gasjm/app/data/repository/estadopedido_repository.dart';
import 'package:get/get.dart';

class EstadoPedidoRepositoryImpl extends EstadoPedidoRepository {
  final _provider = Get.find<EstadoPedidoProvider>();
  @override
  Future<void> deleteEstadoPedido({required String estadopedido}) =>
      _provider.deleteEstadoPedido(estadopedido: estadopedido);

  @override
  Future<EstadoPedidoModel?> getEstadoPedidoPorId({required String id}) =>
      _provider.getEstadoPedidoPorId(id: id);

  @override
  Future<List<EstadoPedidoModel>?> getEstadoPedidoPorField(
          {required String field, required String dato}) =>
      _provider.getEstadoPedidoPorField(field: field, dato: dato);

  @override
  Future<List<EstadoPedidoModel>?> getEstadosPedido() =>
      _provider.getEstadosPedido();

  @override
  Future<void> insertEstadoPedido({required EstadoPedidoModel estadopedido}) =>
      _provider.insertEstadoPedido(estadopedido: estadopedido);

  @override
  Future<void> updateEstadoPedido({required EstadoPedidoModel estadopedido}) =>
      _provider.updateEstadoPedido(estadopedido: estadopedido);
}
