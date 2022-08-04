import 'package:gasjm/app/modules/ubicacion/ubicacion_controller.dart';
import 'package:get/get.dart';

class UbicacionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UbicacionController());
  }
}
