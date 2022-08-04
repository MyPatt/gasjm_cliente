import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get.dart';

class InicioBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut(() => InicioController());
  }
}