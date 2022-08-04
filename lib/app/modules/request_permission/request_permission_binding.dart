import 'package:gasjm/app/modules/request_permission/request_permission_controller.dart';
import 'package:get/get.dart';

class RequestPermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestPermissionController());
  }
  /** */
  
}
