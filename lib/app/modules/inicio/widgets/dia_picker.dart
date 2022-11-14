import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get.dart';

// Widget para seleccionar la fecha de entrega del pedido
class DiaPicker extends StatelessWidget {
  const DiaPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
      builder: (_) => AlertDialog(
        title: const TextSubtitle(text: 'Elija el día'),
        content: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.00))),
          height: Responsive.getScreenSize(context).height * .2,
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /*    _buildHandle(context),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    const TextSubtitle(
                      text: "Nuevo pedido",
                    ),
                    const TextDescription(text: 'Elija el día'),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .03),*/
                    Expanded(
                      child: SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .05,
                          child: CupertinoPicker(
                              selectionOverlay:
                                  const CupertinoPickerDefaultSelectionOverlay(
                                background: Colors.black12,
                              ),
                              scrollController: FixedExtentScrollController(
                                  initialItem: _.diaInicialSeleccionado.value),
                              itemExtent: 25.0,
                              magnification: 2.35 / 2.7,
                              squeeze: 1.5,
                              useMagnifier: true,
                              onSelectedItemChanged: (item) {
                                _.itemSeleccionadoDia.value = item;
                              },
                              children: const <Widget>[
                                TextSubtitle(
                                  text: 'Ahora',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                TextSubtitle(
                                  text: "Mañana",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
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
      ),
    );
  }
}
