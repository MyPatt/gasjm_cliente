import 'package:gasjm/app/modules/identificacion/identificacion_controller.dart';
import 'package:get/get.dart';

class IdentificacionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IdentificacionController());
  }
}
