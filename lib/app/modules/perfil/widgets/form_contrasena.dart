import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
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
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: AppTheme.blueBackground,
          title: const Text('Cambiar contraseña'),
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: SizedBox(
              height: Responsive.hp(context) * 0.83,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                height: 350,
                padding: const EdgeInsets.symmetric(horizontal: 20),

                alignment: Alignment.center,
                // height: Responsive.hp(context),
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constraint.maxHeight * .05),
                        child: Obx(
                          () => AbsorbPointer(
                            absorbing: _.cargandoDeContrasena.value,
                            child: Form(
                              key: _.claveFormContrasena,
                              child: CustomScrollView(slivers: [
                                SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: AppTheme.light,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.lock_person_outlined,
                                              color: AppTheme.blueDark,
                                              size: 50,
                                            ),
                                            radius: 55.0,
                                          ),
                                          radius: 56.0,
                                        ),
                                        SizedBox(
                                            height: Responsive.getScreenSize(
                                                        context)
                                                    .height *
                                                .05),
                                        const TextDescription(
                                            text: 'Ingrese los datos'),
                                        SizedBox(
                                            height: Responsive.getScreenSize(
                                                        context)
                                                    .height *
                                                .05),
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
                                            iconPrefix: Icons.lock_outlined,
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
                                            iconPrefix: Icons.lock_outlined,
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
                                            labelText: "Confirmar contraseña",
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
                                              Visibility(
                                                visible: !_
                                                    .cargandoDeContrasena.value,
                                                child: PrimaryButton(
                                                    texto: "Guardar",
                                                    onPressed: () {
                                                      if (_.claveFormContrasena
                                                              .currentState
                                                              ?.validate() ==
                                                          true) {
                                                        _.restablecerContrasena(
                                                            context);
                                                      }
                                                    }),
                                              ),
                                              if (estadoProceso)
                                                const CircularProgress()
                                            ],
                                          );
                                        }),
                                        //
                                      ]),
                                ),
                              ]),
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
