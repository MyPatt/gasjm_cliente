import 'package:gasjm/app/data/providers/horario_provider.dart';
import 'package:gasjm/app/data/providers/notificacion_provider.dart';
import 'package:gasjm/app/data/repository/horario_repository.dart';
import 'package:gasjm/app/data/repository/implementations/horario_repository.dart';
import 'package:gasjm/app/data/providers/pedido_provider.dart';
import 'package:gasjm/app/data/providers/perfil_provider.dart';
import 'package:gasjm/app/data/providers/persona_provider.dart';
import 'package:gasjm/app/data/providers/producto_provider.dart';
import 'package:gasjm/app/data/repository/implementations/notificacion_repository.dart'; 
import 'package:gasjm/app/data/repository/implementations/pedido_repository.dart';
import 'package:gasjm/app/data/repository/implementations/perfil_repository.dart';
import 'package:gasjm/app/data/repository/implementations/persona_repository.dart';
import 'package:gasjm/app/data/repository/implementations/producto_repository.dart';
import 'package:gasjm/app/data/repository/notificacion_repository.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/perfil_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/data/repository/producto_repository.dart';

import 'package:get/get.dart';

class DependencyInjection {
  static void load() async {
  



    //Providers
    Get.put<PedidoProvider>(PedidoProvider());
    Get.put<ProductoProvider>(ProductoProvider()); 
    Get.put<PerfilProvider>(PerfilProvider());
    Get.put<PersonaProvider>(PersonaProvider());

    //Local
 Get.put<HorarioProvider>(HorarioProvider());
 Get.put<NotificacionProvider>(NotificacionProvider());

    Get.put<HorarioRepository>(HorarioRepositoryImpl());
    //Respositories


    Get.put<PedidoRepository>(PedidoRepositoryImpl());
    Get.put<ProductoRepository>(ProductoRepositoryImpl()); 
    Get.put<PerfilRepository>(PerfilRepositoryImpl());
    Get.put<PersonaRepository>(PersonaRepositoryImpl());
    Get.put<NotificacionRepository>(NotificacionRepositoryImpl());

    //Local
  }
}
