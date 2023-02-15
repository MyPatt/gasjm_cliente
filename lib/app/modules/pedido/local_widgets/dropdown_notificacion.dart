import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/pedido/proceso_pedido_controller.dart';import 'package:gasjm/app/core/utils/globals.dart' as globals;
import 'package:get/get.dart';

class PopuMenuNotificacion extends StatelessWidget {
  const PopuMenuNotificacion({
    Key? key,
  }) : super(key: key); 

//

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcesoPedidoController>(
      builder: (_) => PopupMenuButton(
        padding: const EdgeInsets.all(0.0),
        offset: Offset(0.0, AppBar().preferredSize.height),
        icon: Obx(()=>(Icon(globals.existeNotificacion.value
                      ? Icons.notifications_active_outlined
                      : Icons.notifications_none_outlined))),
        itemBuilder: (ctx) => _.notificaciones
            .map((e) => PopupMenuItem(
                onTap: () => _.cargarDetalle(),
                enabled: false,
                child: Column(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppTheme.blueDark,
                    ),
                    Column(children: [
                      Row(
                        children: [
                          TextSubtitle(
                              text: e.split(',')[0], color: Colors.black38),
                          //   TextDescription(text: e.split(',')[1]),
                          Text(
                            e.split(',')[1],
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            e.split(',')[2],
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ]),
                  ],
                )))
            .toList(),
      ),
    );
  }
}
