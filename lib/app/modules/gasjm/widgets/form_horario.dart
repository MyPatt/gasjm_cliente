import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart'; 
import 'package:get/get.dart';

class FormHorario extends StatelessWidget {
  const FormHorario({Key? key, required this.horario})
      : super(key: key);
  final HorarioModel horario; 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GasJMController>(
      builder: (_) => Card(
        //  shape: Border.all(color: AppTheme.light, width: 0.5),
        elevation: 0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
          //
          child: ListTile(
          
            title: Row(
              children: [
                Column(children: <Widget>[
                  TextSubtitle(
                    text: HorarioModel.diasSemana[horario.idDiaHorario - 1]
                            ['nombreDia']
                        .toString(),
                  ),
                ]),
                //    const Spacer(),
                const Spacer(),
                Column(
                  children: <Widget>[
                    TextDescription(
                        text:
                            '${horario.aperturaHorario} - ${horario.cierreHorario}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
