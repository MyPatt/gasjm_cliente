import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';

class NotificacionEstado extends StatelessWidget {
  const NotificacionEstado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              height: Responsive.getScreenSize(context).height * .05,
              width: Responsive.getScreenSize(context).width * .95,
              child: const TextDescription(
                text: 'Su pedido se encuentra procesando',
                textAlign: TextAlign.left,
              )),
        ),
      ],
    );
  }
}
