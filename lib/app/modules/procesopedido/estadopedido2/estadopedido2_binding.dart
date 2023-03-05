import 'package:gasjm/app/modules/procesopedido/estadopedido2/estadopedido2_controller.dart';
import 'package:get/get.dart';

class EstadoPedido2Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EstadoPedido2Controller());
  }
}
