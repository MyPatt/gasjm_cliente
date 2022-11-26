import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';

abstract class PedidoRepository {
  Future<void> insertPedido({required PedidoModel pedidoModel});
  Future<void> updatePedido({required PedidoModel pedidoModel});
  Future<void> deletePedido({required String pedido});
  Future<List<PedidoModel>?> getPedidos();
  Future<List<PedidoModel>?> getListaPedidosPorField(
      {required String field, required String dato});
  Future<PedidoModel?> getPedidoPorField(
      {required String field, required String dato});
  Future<List<PedidoModel>?> getPedidosPorDosQueries({
    required String field1,
    required String dato1,
    required String field2,
    required String dato2,
  });
  Future<String?> getDescripcionEstadoPedido({required String idEstado});

  Future<String?> getNombreEstadoPedidoPorId({required String idEstado});
  Future<EstadoDelPedido?> getEstadoPedidoPorField({
    required String uid,
    required String field,
  });

   Future<void> updateEstadoPedido(
      {required String idPedido, required String estadoPedido,required String numeroEstadoPedido});
 
}
