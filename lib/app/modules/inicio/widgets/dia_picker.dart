import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/secondary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get.dart';

// Widget para seleccionar la fecha de entrega del pedido
class DiaPicker extends StatelessWidget {
  const DiaPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
      builder: (_) => Container(
        padding:
            const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0, bottom: 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        height: Responsive.getScreenSize(context).height * .5,
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHandle(context),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .02),
                  const TextSubtitle(
                    text: "Nuevo pedido",
                  ),
                  const TextDescription(text: 'Elija el día'),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .03),
                  Expanded(
                    child: SizedBox(
                        height: Responsive.getScreenSize(context).height * .1,
                        child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: _.diaInicialSeleccionado.value),
                            itemExtent: 32.0,
                            magnification: 2.35 / 2.1,
                            squeeze: 1.25,
                            useMagnifier: true,
                            onSelectedItemChanged: (item) {
                              _.itemSeleccionadoDia.value = item;
                            },
                            children: const <Widget>[
                              Text(
                                "Ahora",
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Mañana",
                                textAlign: TextAlign.center,
                              )
                            ])),
                  ),

                  /* PrimaryButton(
                      texto: 'Hecho',
                      onPressed: () {
                        Navigator.of(context).pop();
                        _.guardarDiaDeEntregaPedido();
                      }),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .02),
                  SecondaryButton(
                      texto: 'Cerrar',
                      onPressed: () {
                        _.itemSeleccionadoDia.value = 0;
                        Navigator.of(context).pop();
                      }),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .02),*/
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cerrar",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(color: Colors.black54),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _.guardarDiaDeEntregaPedido();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Hecho",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  color: AppTheme.blueDark,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .02),
                ],
              ))
        ]),
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}
