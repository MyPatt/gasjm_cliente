import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:get/get.dart';

class FormRuta extends StatelessWidget {
  const FormRuta({Key? key, required this.horario}) : super(key: key);
  final HorarioModel horario;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GasJMController>(
      builder: (_) => Card(
        //  shape: Border.all(color: AppTheme.light, width: 0.5),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.09, color: AppTheme.light),
          borderRadius: BorderRadius.circular(15.0),
        ),
        //elevation: 0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0.0),
          //
          child: ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextSubtitle(
                      text: HorarioModel.diasSemana[horario.idDiaHorario - 1]
                              ['nombreDia']
                          .toString(),
                      // style: TextoTheme.subtitleStyle2,
                    ),
                    const Spacer(),
                    const TextSubtitle(
                      text: "Freddy Bonilla",
                      //  style: TextoTheme.subtitleStyle2
                    )
                  ],
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    TextSubtitle(
                      text: "Mañana", color: Colors.black38,
                      // style: TextoTheme.subtitleStyle2,
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    TextDescription(
                      text: "Santa Rosa",
                      // style: TextoTheme.subtitleStyle2,
                    ),
                  ],
                ),
                SizedBox(
                    height: Responsive.getScreenSize(context).height * .05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    TextSubtitle(
                      text: "Tarde",
                      color: Colors.black38,
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    TextDescription(
                      text: "Santa Rosa",
                      // style: TextoTheme.subtitleStyle2,
                    ),
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
