import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrarController extends GetxController {
  //Variables para ocultar el texto de la contrasena
  final RxBool _contrasenaOculta = true.obs;
  RxBool get contrasenaOculta => _contrasenaOculta;
//Clave del formulario de resgistro de usuario
  final claveFormRegistrar = GlobalKey<FormState>();

  //Variables para controladores de campos de texto del formulario
  final nombreTextoController = TextEditingController();
  final apellidoTextoController = TextEditingController();
  final correoElectronicoTextoController = TextEditingController();
  final contrasenaTextoController = TextEditingController();

  //Variable para guardar la cedula
  late String cedula = '';
  //late String perfil = '';
  final perfil = "cliente";

  //Existe algun error si o no
  final errorParaCorreo = Rx<String?>(null);
  //Se cago si o no
  final cargandoParaCorreo = RxBool(false);

  @override
  void onInit() {
    _obtenerCedulaYPerfil();

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

//Visualizar texto de lacontrasena
  void mostrarContrasena() {
    _contrasenaOculta.value = _contrasenaOculta.value ? false : true;
  }

//
  cargarLogin() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed(AppRoutes.login);
    } catch (e) {
      // print(e);
    }
  }

  /* REGISTRO CON CORREO EN FIREBASE */
  final _authRepository = Get.find<AutenticacionRepository>();

  //Metodo para registrar

  Future<void> registrarUsuario() async {
    //Obtener datos
    final nombre = nombreTextoController.text;
    final apellido = apellidoTextoController.text;
    final correo = correoElectronicoTextoController.text;
    final contrasena = contrasenaTextoController.text;

    //Guardar en model
    PersonaModel usuarioDatos = PersonaModel(
        cedulaPersona: cedula,
        nombrePersona: nombre,
        apellidoPersona: apellido,
        idPerfil: perfil,
        contrasenaPersona: contrasena,
        correoPersona: correo);

//
    try {
      cargandoParaCorreo.value = true;

      errorParaCorreo.value = null;

//En firebase
      await _authRepository.registrarUsuario(usuarioDatos);
//Remover datos locales
      _removerCedulaYPerfil();

      //Mensaje de ingreso
      Mensajes.showGetSnackbar(
          titulo: 'Mensaje',
          mensaje: '¡Bienvenido a GasJM!',
          icono: const Icon(
            Icons.waving_hand_outlined,
            color: Colors.white,
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorParaCorreo.value = 'La contraseña es demasiado débil';
      } else if (e.code == 'email-already-in-use') {
        errorParaCorreo.value =
            'La cuenta ya existe para ese correo electrónico';
      } else {
        errorParaCorreo.value = e.message;
      }
    }
    cargandoParaCorreo.value = false;
  }

//Obtener cedula de forma local
  _obtenerCedulaYPerfil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final s = prefs.getString("cedula_usuario");
    //final p = await prefs.getString("perfil_usuario");
    cedula = s ?? '';
    //perfil = p ?? '';
  }

  //Eliminar la cedula del usuario de forma local
  _removerCedulaYPerfil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("cedula_usuario");
    //  await prefs.remove("perfil_usuario");
  }
}
