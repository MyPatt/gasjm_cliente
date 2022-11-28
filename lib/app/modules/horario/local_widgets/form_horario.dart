import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:flutter/material.dart';

class FormHorario extends StatelessWidget {
  const FormHorario({Key? key, required this.horario}) : super(key: key);
  final HorarioModel horario;
  @override
  Widget build(BuildContext context) {
    return Card(
      //  shape: Border.all(color: AppTheme.light, width: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Column(children: <Widget>[
              TextSubtitle(
                text: HorarioModel.diasSemana[horario.idDiaHorario - 1]
                        ['nombreDia']
                    .toString(),
              ),
            ]),
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
    );
    ;
  }
}
