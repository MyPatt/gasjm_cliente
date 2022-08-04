import 'package:gasjm/app/modules/agenda/cliente/local_widgets/editar/editar_controller.dart'; 
import 'package:get/get.dart';

class EditarPedidoAgendadoBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut(() => EditarAgendaController());
  }
}