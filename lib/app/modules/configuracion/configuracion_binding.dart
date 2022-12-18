import 'package:gasjm/app/modules/configuracion/configuracion_controller.dart';
 
import 'package:get/get.dart';

class ConfiguracionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConfiguracionController());
  }
}
