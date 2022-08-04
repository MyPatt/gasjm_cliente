import 'dart:async'; 

import 'package:gasjm/app/modules/request_permission/request_permission.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionController extends GetxController {


  //
  final controller = RequestPermission(Permission.locationWhenInUse);
  late StreamSubscription _subscription;
  @override
  void onInit() {
 
  _subscription=  controller.onStatesChanged.listen((status) {
    if (status==PermissionStatus.granted) {
      Get.toNamed(AppRoutes.inicio);
      
    }
  });
    super.onInit();
  }

  @override
  void onClose() {
    _subscription.cancel();
    controller.dispose();
    super.onClose();
  }
}
