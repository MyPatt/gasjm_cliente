import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/notificacion/local_widgets/item_notificacion.dart';
import 'package:gasjm/app/modules/notificacion/notificacion_controller.dart';
import 'package:get/get.dart';

class ContenidoNotificacion extends StatelessWidget {
  const ContenidoNotificacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                //Muestra la lista de notificaciones en caso de existir caso contrario texto de sin noti...
                child: GetBuilder<NotificacionController>(
                    builder: (_) => Obx(
                          () => !_.notificaciones.isNotEmpty
                              ? const Center(
                                  child: TextDescription(
                                      text: "Sin notifiaciones!"))
                              : ListView.builder(
                                  itemCount: _.notificaciones.length,
                                  itemBuilder: (ctx, index) => GestureDetector(
                                      onTap: () => _.cargarDetalle(),
                                      child: ItemNotificacion(
                                          notificacion:
                                              _.notificaciones[index], onTap: () =>_.cargarDetalle(),))),
                        )))
          ],
        ),
      )
    ]);
  }
}
