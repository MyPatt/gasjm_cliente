import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/horario/horario_controller.dart';
import 'package:get/get.dart';

class HorarioPage extends StatelessWidget {
  const HorarioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var cryptoData = CryptoData.getData;
    return GetBuilder<HorarioController>(
        builder: (_) => Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              automaticallyImplyLeading: true,
              backgroundColor: AppTheme.blueBackground,
              elevation: 0.0,
              title: const Text(
                "Horario de atención",
              ),
            ),
            body: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Obx(
                    () => Expanded(
                      child: ListView.builder(
                          // scrollDirection: Axis.horizontal,
                          itemCount: _.listaHorarios.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              //  shape: Border.all(color: AppTheme.light, width: 0.5),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Column(children: <Widget>[
                                      TextSubtitle(
                                        text: HorarioModel.diasSemana[_
                                                    .listaHorarios[index]
                                                    .idDiaHorario -
                                                1]['nombreDia']
                                            .toString(),
                                      ),
                                    ]),
                                    Spacer(),
                                    Column(
                                      children: <Widget>[
                                        TextDescription(
                                            text:
                                                '${_.listaHorarios[index].aperturaHorario} - ${_.listaHorarios[index].cierreHorario}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            )));
  }
}
