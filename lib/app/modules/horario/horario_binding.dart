
import 'package:gasjm/app/modules/horario/horario_controller.dart';
import 'package:get/get.dart';

class HorarioBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut(() => HorarioController());
  }
}