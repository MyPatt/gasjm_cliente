import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class UbicacionController extends GetxController {
  RxBool _isOscure = true.obs;
  RxBool get isOscure => _isOscure;
  //
  final cargando = RxBool(false);
  //PermissionStatus _status;

  @override
  void onInit() {
    super.onInit();
    //
    /* PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
        .then(_updateStatus);*/
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  cargarIdentificacion() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed(AppRoutes.identificacion);
    } catch (e) {
      print(e);
    }
  }  cargarUbicacion() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed(AppRoutes.ubicacion);
    } catch (e) {
      print(e);
    }
  }
/*
  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }*/
}
