import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:location/location.dart'; 

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
  String cedula = '';
  //late String perfil = '';
  final perfil = "cliente";

  //Existe algun error si o no
  final errorParaCorreo = Rx<String?>(null);
  //Se cago si o no
  final cargandoParaCorreo = RxBool(false);

  @override
  void onInit() {
    //Obtener argumento cedula
    cedula = Get.arguments;

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    nombreTextoController.dispose();
    apellidoTextoController.dispose();
    correoElectronicoTextoController.dispose();
    contrasenaTextoController.dispose();
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
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          duracion: const Duration(seconds: 4),
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
  }

  /* REGISTRO CON CORREO EN FIREBASE */
  final _authRepository = Get.find<AutenticacionRepository>();

  //Metodo para registrar

  Future<void> registrarCliente() async {
    //Obtener datos
    final nombre = nombreTextoController.text;
    final apellido = apellidoTextoController.text;
    final correo = correoElectronicoTextoController.text;
    String contrasena = contrasenaTextoController.text;
//
    try {
      cargandoParaCorreo.value = true;
      errorParaCorreo.value = null;
      //
      //
      LocationData location = await Location.instance.getLocation();
      Direccion direccionPersona = Direccion(
          latitud: location.latitude ?? 0.0,
          longitud: location.longitude ?? 0.0);

      //Guardar en model
      PersonaModel usuarioDatos = PersonaModel(
          cedulaPersona: cedula,
          nombrePersona: nombre,
          apellidoPersona: apellido,
          estadoPersona: "activo",
          idPerfil: perfil,
          contrasenaPersona: contrasena,
          correoPersona: correo,
          direccionPersona: direccionPersona);

//Testear
      await Future.delayed(const Duration(seconds: 1));
//En firebase
      await _authRepository.registrarUsuario(usuarioDatos);

      //

      //Mensaje de ingreso
      Mensajes.showGetSnackbar(
          titulo: 'Mensaje',
          mensaje: '¡Bienvenido a GasJM!',
          icono: const Icon(
            Icons.waving_hand_outlined,
            color: Colors.white,
          ));
      //
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorParaCorreo.value = 'La contraseña es demasiado débil';
      } else if (e.code == 'email-already-in-use') {
        errorParaCorreo.value =
            'La cuenta ya existe para ese correo electrónico';
      } else {
        errorParaCorreo.value = "Se produjo un error inesperado.";
      }
    } catch (e) {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          duracion: const Duration(seconds: 4),
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    cargandoParaCorreo.value = false;
  }
}
