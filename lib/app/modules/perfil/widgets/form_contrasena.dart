import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/perfil/perfil_controller.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:get/get.dart';

class FormContrasena extends StatelessWidget {
  const FormContrasena({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppTheme.blueBackground,
          title: const Text('Cambiar contraseña'),
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                        padding:
                            EdgeInsets.only(bottom: constraint.maxHeight * .1),
                        child: Obx(
                          () => AbsorbPointer(
                            absorbing: _.cargandoDeContrasena.value,
                            child: Form(
                              key: _.claveFormContrasena,
                              child: CustomScrollView(slivers: [
                                SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Obx(
                                          () => InputText(
                                            iconPrefix: Icons.lock_outlined,
                                            keyboardType: TextInputType.text,
                                            obscureText:
                                                _.contrasenaActualOculta.value,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: _
                                                .contrasenaActualTextoController,
                                            validator:
                                                Validacion.validarContrasena,
                                            maxLines: 1,
                                            labelText: "Contraseña actual",
                                            suffixIcon: GestureDetector(
                                              onTap: _.mostrarContrasenaActual,
                                              child: Icon(
                                                _.contrasenaActualOculta.value
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                                color: AppTheme.light,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: Responsive.getScreenSize(
                                                        context)
                                                    .height *
                                                .02),
                                        Obx(
                                          () => InputText(
                                            iconPrefix: Icons.lock_reset,
                                            keyboardType: TextInputType.text,
                                            obscureText:
                                                _.contrasenaNuevaOculta1.value,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: _
                                                .contrasenaNueva1TextoController,
                                            validator:
                                                Validacion.validarContrasena,
                                            maxLines: 1,
                                            labelText: "Contraseña nueva",
                                            suffixIcon: GestureDetector(
                                              onTap: _.mostrarContrasenaNueva1,
                                              child: Icon(
                                                _.contrasenaNuevaOculta1.value
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                                color: AppTheme.light,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: Responsive.getScreenSize(
                                                        context)
                                                    .height *
                                                .02),
                                        Obx(
                                          () => InputText(
                                            iconPrefix: Icons.lock_reset,
                                            keyboardType: TextInputType.text,
                                            obscureText:
                                                _.contrasenaNuevaOculta2.value,
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: _
                                                .contrasenaNueva2TextoController,
                                            validator:
                                                Validacion.validarContrasena,
                                            maxLines: 1,
                                            labelText: "Contraseña nueva",
                                            suffixIcon: GestureDetector(
                                              onTap: _.mostrarContrasenaNueva2,
                                              child: Icon(
                                                _.contrasenaNuevaOculta2.value
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                                color: AppTheme.light,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: Responsive.getScreenSize(
                                                        context)
                                                    .height *
                                                .02),
                                        Obx(() => Visibility(
                                            visible: _.errorDeContrasena.value
                                                    ?.isNotEmpty ==
                                                true,
                                            child: TextDescription(
                                              text: _.errorDeContrasena.value ??
                                                  '',
                                              color: Colors.red,
                                            ))),

                                        SizedBox(
                                            height: Responsive.getScreenSize(
                                                        context)
                                                    .height *
                                                .05),
                                        Obx(() {
                                          final estadoProceso =
                                              _.cargandoDeContrasena.value;
                                          return Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              PrimaryButton(
                                                  texto: "Guardar",
                                                  onPressed: () {
                                                    if (_.claveFormContrasena
                                                            .currentState
                                                            ?.validate() ==
                                                        true) {
                                                      _.restablecerContrasena();
                                                    }
                                                  }),
                                              if (estadoProceso)
                                                const CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.white),
                                            ],
                                          );
                                        }),
                                        //
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .05),
                                      ]),
                                ),
                              ]),
                            ),
                          ),
                        )),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
