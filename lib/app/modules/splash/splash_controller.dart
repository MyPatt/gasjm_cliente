import 'package:flutter/cupertino.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
//
  final Permission _locationPermission=Permission.locationWhenInUse;
  String? _routeName;

  //SplashController(this._locationPermission);

  String? get routeName => _routeName;

  Future<void> checkPermission() async {
    final isGranted = await _locationPermission.isGranted;
    _routeName = isGranted ? AppRoutes.inicio : AppRoutes.permission;
  }

//
  @override
  void onInit() {
 /*   WidgetsBinding.instance.addPostFrameCallback((_) {
      checkPermission();
    });
    addListener(() {
      if (routeName != null) {
        //  Navigator.pushReplacementNamed(context, routeName);
        print("<<<ROUTE NAME>>>\n");
      }
    });*/
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
}
