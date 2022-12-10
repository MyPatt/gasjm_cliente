import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/notificacion_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';

abstract class NotificacionRepository {
  Future<void> insertNotificacion({required Notificacion notificacionModel});
  Future<List<Notificacion>?> getNotificaciones();
}
