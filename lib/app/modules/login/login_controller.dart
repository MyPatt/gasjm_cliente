import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';

import 'package:get/get.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  ///

  final RxBool _contrasenaOculta = true.obs;
  RxBool get contrasenaOculta => _contrasenaOculta;

  //Variables para el form
  final formKey = GlobalKey<FormState>();

  final correoTextoController = TextEditingController();
  final contrasenaTextoController = TextEditingController();

  bool isProcessing = false;
  //Toast para notificar el inicio de sesion
  Fluttertoast? flutterToast;
//
  @override
  void onInit() {
    flutterToast = Fluttertoast();
    _obtenerCorreo();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    //
    _removerCorreo();
    super.onClose();
  }

  void mostrarContrasena() {
    _contrasenaOculta.value = _contrasenaOculta.value ? false : true;
  }

  //** Autenticacion para iniciar sesion **
  //Dependencia de AutenticacionRepository
  final _autenticacioRepository = Get.find<AutenticacionRepository>();
  //Existe algun error si o no
  final errorParaSocialMedia = Rx<String?>(null);
  //Se cago si o no
  final cargandoParaSocialMedia = RxBool(false);

//Iniciar sesion con Google
  Future<void> iniciarSesionConGoogle() =>
      _iniciarSesion(_autenticacioRepository.iniciarSesionConGoogle);

  //Metodo que rige para iniciar sesion con el progress
  Future<void> _iniciarSesion(
      Future<AutenticacionUsuario?> Function() auxUsuario) async {
    try {
      cargandoParaSocialMedia.value = true;
      errorParaSocialMedia.value = null;

      await auxUsuario();
      //
      // Mensajes.showToastBienvenido("Bienvenido...");
      Get.snackbar(
        '',
        '¡Bienvenido a GasJM!',
        duration: const Duration(seconds: 4),
        backgroundColor: AppTheme.blueDark,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 0,
        
      );
    } on FirebaseException catch (e) {
      //:TODO OJO implementar error
      errorParaSocialMedia.value = e.code;
    } catch (e) {
      errorParaSocialMedia.value =
          "Error de inicio de sesión. Inténtalo de nuevo.";
    }
    cargandoParaSocialMedia.value = false;
  }

//Inicar sesion con correo

  //Existe algun error si o no
  final errorParaCorreo = Rx<String?>(null);
  //Se cargo si o no
  final cargandoParaCorreo = RxBool(false);

  Future<void> iniciarSesionConCorreoYContrasena() async {
    try {
      cargandoParaCorreo.value = true;

      errorParaCorreo.value = null;
      await _autenticacioRepository.iniciarSesionConCorreoYContrasena(
        correoTextoController.text,
        contrasenaTextoController.value.text,
      );
      //
      //Mensajes.showToastBienvenido("Bienvenido...");
      Get.snackbar(
        'Mensaje',
          '¡Bienvenido a GasJM!',
        duration: const Duration(seconds: 4),
        backgroundColor: AppTheme.blueDark,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 0,
        
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorParaCorreo.value =
            'Ningún usuario encontrado con ese correo electrónico.';
      } else if (e.code == 'wrong-password') {
        errorParaCorreo.value = 'Contraseña incorrecta.';
      }
    } catch (e) {
      errorParaCorreo.value = 'Error de inicio de sesión. Inténtalo de nuevo.';
    }
    cargandoParaCorreo.value = false;
  }

  //Obtener correo de forma local
  _obtenerCorreo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final s = prefs.getString("correo_usuario");
    correoTextoController.text = s ?? '';
  }

  //Remover correo de forma local
  _removerCorreo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("correo_usuario");
  }
}
