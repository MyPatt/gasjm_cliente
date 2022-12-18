import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/proceso_pedido/proceso_pedido_controller.dart';
import 'package:get/get.dart';

class PopuMenuNotificacion extends StatelessWidget {
  const PopuMenuNotificacion({
    Key? key,
    required this.icono,
  }) : super(key: key);
  final Widget icono;

//

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcesoPedidoController>(
      builder: (_) => GestureDetector(
        onTap: () {
          print("object");
        },
        //=> _.cargarListaNotificaciones(),
        child: PopupMenuButton(
          offset: Offset(0.0, AppBar().preferredSize.height),
          icon: icono,
          itemBuilder: (ctx) => _.notificaciones
              .map((e) => PopupMenuItem(
                      child: Column( 
                    children: [
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
                      )
                    ],
                  )))
              .toList(),
          // [const PopupMenuItem(child: Text("Sin notificaciones"))],
          //enabled: popupsNotificacion?.isNotEmpty ?? false,
          onSelected: (value) {
            print(value as int);
            //   _.cargarDetalle(  _.notificaciones![value as int].idPedidoNotificacion ?? '');
          },
        ),
      ),
    );
  }
}
