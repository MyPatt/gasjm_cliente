import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
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
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 5,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              // height: Responsive.getScreenSize(context).height * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50.0,
                      height: 5.0,
                      margin: const EdgeInsets.only(bottom: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  // _buildHandle(context),
                  SizedBox(
                      height: Responsive.getScreenSize(context).height * .02),
                  SizedBox(
                    height: Responsive.hp(context) * 0.45,
                    child: Obx(
                      () => AbsorbPointer(
                        absorbing: _.procensandoElNuevoPedido.value,
                        child: Form(
                          key: _.formKey,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              const TextSubtitle(
                                text: "Nuevo pedido",
                              ),
                              const TextDescription(
                                  text:
                                      "Ingrese los datos para realizar su pedido"),
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .03),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: InputText(
                                  controller: _.direccionTextController,
                                  keyboardType: TextInputType.streetAddress,
                                  iconPrefix: Icons.room_outlined,
                                  labelText: "Dirección",
                                  validator: Validacion.validarDireccion,
                                  readOnly: true,
                                  enabled: false,
                                  // enabled: true,
                                ),
                              ),
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .02),
                              Obx(() => InputText(
                                    iconPrefix: Icons.calendar_today_outlined,
                                    keyboardType: TextInputType.none,
                                    controller:
                                        _.diaDeEntregaPedidoController.value,
                                    labelText: "Fecha",
                                    readOnly: true,
                                    onTap: () {
                                      /* showDialog(
                                              context: context,
                                              //backgroundColor: Colors.transparent,
                                              builder: (_) => const DiaPicker());*/
                                    },
                                  )),
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .02),
                              InputText(
                                controller: _.cantidadTextoController,
                                iconPrefix: Icons.pin_outlined,
                                keyboardType: TextInputType.phone,
                                //validator: null,
                                labelText: "Cantidad",

                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(2),
                                  FilteringTextInputFormatter.digitsOnly,
                                  //FilteringTextInputFormatter.allow(RegExp(r'\d{1,2}')),
                                ],
                                validator: Validacion.validarCantidadGas,
                                onChanged: _.onChangedCantidad,
                                filled: false,
                              ),
                              Obx(
                                () => InputText(
                                  readOnly: true,
                                  enabled: false,
                                  controller: _.totalTextoController.value,
                                  iconPrefix: Icons.attach_money_outlined,
                                  labelText: "Total",
                                ),
                              ),
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .02),
                              InputText(
                                controller: _.notaTextoController,
                                iconPrefix: Icons.note_outlined,
                                labelText: "Nota",
                                textInputAction: TextInputAction.none,
                              ),
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .05),
                              Obx(() {
                                final estadoGuardar =
                                    _.procensandoElNuevoPedido.value;
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Visibility(
                                      visible:
                                          !_.procensandoElNuevoPedido.value,
                                      child: PrimaryButton(
                                        texto: "Pedir el gas",
                                        onPressed: () {
                                          if (_.formKey.currentState
                                                  ?.validate() ==
                                              true) {
                                            _.insertarPedido();
                                          }
                                        },
                                      ),
                                    ),
                                    if (estadoGuardar) const CircularProgress()
                                  ],
                                );
                              }),
                              SizedBox(
                                  height:
                                      Responsive.getScreenSize(context).height *
                                          .03),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
