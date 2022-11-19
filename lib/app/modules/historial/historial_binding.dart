import 'package:gasjm/app/modules/historial/historial_controller.dart';
import 'package:get/get.dart';

class HistorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistorialController());
  }
}
