import 'package:flutter/material.dart'; 
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
      builder: (_) => PopupMenuButton(
        padding: const EdgeInsets.all(0.0),
       
        offset: Offset(0.0, AppBar().preferredSize.height),
        icon: icono,
        itemBuilder: (ctx) => _.notificaciones
            .map((e) => PopupMenuItem(
                padding: const EdgeInsets.all(0.0),
                onTap: () => _.cargarDetalle(),
                child: Card(
                  elevation: 0.4,
                  child: ListTile(
                    title: Row(
                      children: [
                        TextSubtitle(
                            text: e.split(',')[0], color: Colors.black38),
                        //   TextDescription(text: e.split(',')[1]),
                        Text(
                          e.split(',')[1],
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.black38,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                    subtitle: Row(
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
                  ),
                )))
            .toList(),
      
      ),
    );
  }
}
