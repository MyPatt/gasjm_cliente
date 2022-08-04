import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';

import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/identificacion/identificacion_controller.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:get/get.dart';

class FormIdentificacion extends StatelessWidget {
  const FormIdentificacion({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IdentificacionController>(
      builder: (_) => LayoutBuilder(
        builder: (context, constraint) {
          return Padding(
            padding: EdgeInsets.only(bottom: constraint.maxHeight * .1),
            child: Form(
              key: _.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                      height: 96,
                      child: Image(
                        image: AssetImage("assets/icons/identificacion.png"),
                      )),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .05),
                  Text(
                    "Identificación",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: AppTheme.blue, fontWeight: FontWeight.w900),
                  ),
                  const TextDescription(
                      text:
                          "Ingrese su número de identificación para iniciar sesión"),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .05),
                  InputText(
                    controller: _.cedulaTextoController,
                    autofocus: true,
                    iconPrefix: Icons.credit_card,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: Validacion.validarCedula,
                    labelText: "Cédula",
                  ),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .05),
                  Obx(() {
                    final estadoProceso = _.cargando.value;
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        PrimaryButton(
                            texto: "Siguiente",
                            onPressed: () {
                              if (_.formKey.currentState?.validate() == true) {
                                _.cargarPerfil();
                              }
                            }),
                        if (estadoProceso) const CircularProgressIndicator(backgroundColor: Colors.white),
                      ],
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
