 
import 'package:gasjm/app/modules/notificacion/notificacion_controller.dart';
import 'package:get/get.dart';

class NotificacionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificacionController());
  }
}
