import 'package:gasjm/app/modules/configuracion/configuracion_binding.dart';
import 'package:gasjm/app/modules/configuracion/configuracion_page.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_binding.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_page.dart';
import 'package:gasjm/app/modules/historial/historial_binding.dart';
import 'package:gasjm/app/modules/historial/historial_page.dart';
import 'package:gasjm/app/modules/horario/horario_binding.dart';
import 'package:gasjm/app/modules/horario/horario_page.dart';
import 'package:gasjm/app/modules/identificacion/identificacion_binding.dart';
import 'package:gasjm/app/modules/identificacion/identificacion_page.dart';
import 'package:gasjm/app/modules/inicio/inicio_binding.dart';
import 'package:gasjm/app/modules/inicio/inicio_page.dart';
import 'package:gasjm/app/modules/notificacion/notificacion_binding.dart';
import 'package:gasjm/app/modules/notificacion/notificacion_page.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido1/proceso_pedido_binding.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido1/proceso_pedido_page.dart';
import 'package:gasjm/app/modules/login/login_binding.dart';
import 'package:gasjm/app/modules/login/login_page.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/estadopedido2_binding.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/estadopedido2_page.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/mapa_page.dart';
import 'package:gasjm/app/modules/registrar/registrar_binding.dart';
import 'package:gasjm/app/modules/registrar/registrar_page.dart';
import 'package:gasjm/app/modules/splash/splash_binding.dart';
import 'package:gasjm/app/modules/splash/splash_page.dart';
import 'package:gasjm/app/modules/ubicacion/ubicacion_binding.dart';
import 'package:gasjm/app/modules/ubicacion/ubicacion_page.dart';
import 'package:gasjm/app/modules/perfil/perfil_binding.dart';
import 'package:gasjm/app/modules/perfil/perfil_page.dart';
import 'package:gasjm/app/modules/perfil/widgets/form_contrasena.dart';
import 'package:gasjm/app/modules/perfil/widgets/form_direccion.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.ubicacion,
      page: () => const UbicacionPage(),
      binding: UbicacionBinding(),
      // transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.identificacion,
      page: () => const IdentificacionPage(),
      binding: IdentificacionBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.registrar,
      page: () => const RegistrarPage(),
      binding: RegistrarBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.inicio,
      page: () => const InicioPage(),
      binding: InicioBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.perfil,
      page: () => PerfilPage(),
      binding: PerfilBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.direccion,
      page: () => const FormDireccion(),
      // binding: PerfilBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.contrasena,
      page: () => const FormContrasena(),
      // binding: PerfilBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.procesopedido,
      page: () => const EstadoPedido2Page(),
      binding: EstadoPedido2Binding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.historial,
      page: () => HistorialPage(),
      binding: HistorialBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
       GetPage(
      name: AppRoutes.notificacion,
      page: () => const NotificacionPage(),
      binding: NotificacionBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.gasjm,
      page: () => const GasJMPage(),
      binding: GasJMBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.configuracion,
      page: () => const ConfiguracionPage(),
      binding: ConfiguracionBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.horario,
      page: () => const HorarioPage(),
      binding: HorarioBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
