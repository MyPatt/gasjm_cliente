import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:get/get.dart';

class GasJMBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GasJMController());
  }
}
