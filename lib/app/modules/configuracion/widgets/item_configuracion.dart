import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/configuracion/configuracion_controller.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:get/get.dart';

class ItemConfiguracion extends StatelessWidget {
  const ItemConfiguracion({Key? key, required this.nombreItem})
      : super(key: key);
  final String nombreItem;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfiguracionController>(
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
                    text: nombreItem,
                  ),
                ]),
                //    const Spacer(),
                const Spacer(),
                Column(
                  children: <Widget>[
                    Obx(
                      () => Switch(
                        value: _.isSwitched.value,
                        onChanged: (value) {
                          _.isSwitched.value = value;
                        },
                      ),
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
