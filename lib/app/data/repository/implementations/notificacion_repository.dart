import 'package:gasjm/app/data/models/notificacion_model.dart';
import 'package:gasjm/app/data/providers/notificacion_provider.dart';
import 'package:gasjm/app/data/repository/notificacion_repository.dart';
import 'package:get/get.dart';

class NotificacionRepositoryImpl extends NotificacionRepository {
  final _provider = Get.find<NotificacionProvider>();

  @override
  Future<void> insertNotificacion({required Notificacion notificacionModel}) =>
      _provider.insertNotificacion(notificacionModel: notificacionModel);

  @override
  Future<List<Notificacion>?> getNotificaciones() =>
      _provider.getNotificaciones();
}
