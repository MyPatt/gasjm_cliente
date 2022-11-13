 
import 'package:gasjm/app/modules/proceso_pedido/proceso_pedido_controller.dart';
import 'package:get/get.dart';

class ProcesoPedidoBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut(() => ProcesoPedidoController());
  }
}