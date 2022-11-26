import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/providers/pedido_provider.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:get/get.dart';
import 'package:pod/pod.dart';

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
  Future<List<PedidoModel>?> getListaPedidosPorField(
          {required String field, required String dato}) =>
      _provider.getListaPedidosPorField(field: field, dato: dato);
  @override
  Future<PedidoModel?> getPedidoPorField(
          {required String field, required String dato}) =>
      _provider.getPedidoPorField(field: field, dato: dato);
  @override
  Future<List<PedidoModel>?> getPedidosPorDosQueries({
    required String field1,
    required String dato1,
    required String field2,
    required String dato2,
  }) =>
      _provider.getPedidosPorDosQueries(
          field1: field1, dato1: dato1, field2: field2, dato2: dato2);

  @override
  Future<void> updatePedido({required PedidoModel pedidoModel}) =>
      _provider.updatePedido(pedidoModel: pedidoModel);
  @override
  Future<String?> getDescripcionEstadoPedido({required String idEstado}) =>
      _provider.getDescripcionEstadoPedido(idEstado: idEstado);

  @override
  Future<String?> getNombreEstadoPedidoPorId({required String idEstado}) =>
      _provider.getNombreEstadoPedidoPorId(idEstado: idEstado);
  //
  @override
  Future<EstadoDelPedido?> getEstadoPedidoPorField({
    required String uid,
    required String field,
  }) =>
      _provider.getEstadoPedidoPorField(uid: uid, field: field);
        @override
  Future<void> updateEstadoPedido(
          {required String idPedido, required String estadoPedido,required String numeroEstadoPedido}) =>
      _provider.updateEstadoPedido(
          idPedido: idPedido, estadoPedido: estadoPedido, numeroEstadoPedido: numeroEstadoPedido);

}
