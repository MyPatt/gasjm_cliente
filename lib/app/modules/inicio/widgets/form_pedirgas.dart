import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:gasjm/app/modules/inicio/widgets/dia_picker.dart';
import 'package:get/get.dart';

class FormPedirGas extends StatelessWidget {
  const FormPedirGas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
        builder: (_) => Container(
              //padding: EdgeInsets.only(     bottom: MediaQuery.of(context).viewInsets.bottom,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),

              padding: const EdgeInsets.all(8.0),
              height: Responsive.getScreenSize(context).height * .5,
              child: Center(
                child: Form(
                  key: _.formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      _buildHandle(context),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      const TextSubtitle(
                        text: "Nuevo pedido",
                      ),
                      const TextDescription(
                          text: "Ingrese los datos para realizar su pedido"),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .03),
                      InputText(
                        controller: _.direccionTextoController,
                        keyboardType: TextInputType.streetAddress,
                        iconPrefix: Icons.room_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none,
                        labelText: "Dirección",
                        validator: Validacion.validarDireccion,
                        readOnly: true,
                        filled: false,
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      Obx(() => InputText(
                            iconPrefix: Icons.calendar_today_outlined,
                            iconColor: AppTheme.light,
                            border: InputBorder.none,
                            keyboardType: TextInputType.none,
                            controller: _.diaDeEntregaPedidoController.value,

                            labelText: "Fecha",
                            //readOnly: true,
                            filled: false,

                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (_) => const DiaPicker());
                            },
                          )),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      InputText(
                        controller: _.cantidadTextoController,
                        iconPrefix: Icons.pin_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none,
                        keyboardType: TextInputType.phone,
                        //validator: null,
                        labelText: "Cantidad",

                        inputFormatters: <TextInputFormatter>[
                          //FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.allow(RegExp(r'\d{1,2}')),
                        ],
                        validator: Validacion.validarCantidadGas,
                        filled: false,
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      InputText(
                        controller: _.notaTextoController,
                        keyboardType: TextInputType.streetAddress,
                        iconPrefix: Icons.note_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none,
                        labelText: "Nota",
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp(r'[^\w]')),
                        ],
                        filled: false,
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .05),
                      Obx(() {
                        final isSaving = _.procensandoElNuevoPedido.value;
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            PrimaryButton(
                              texto: "Pedir el gas",
                              onPressed: () {
                                if (_.formKey.currentState?.validate() ==
                                    true) {
                                  _.insertarPedido();
                                }
                              },
                            ),
                            if (isSaving)
                              const CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                          ],
                        );
                      }),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .03),
                    ],
                  ),
                ),
              ),
            ));
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
//TODO: Scroll cuando el teclado se visualiza
