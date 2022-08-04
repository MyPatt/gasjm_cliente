import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AgendaClienteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  cargarEditarAgenda() async {
    print("nnn");
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.editaragenda);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
