import 'package:gasjm/app/modules/agenda/cliente/agenda_cliente_controller.dart';
import 'package:get/get.dart';

class AgendaClienteBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut(() => AgendaClienteController());
  }
}