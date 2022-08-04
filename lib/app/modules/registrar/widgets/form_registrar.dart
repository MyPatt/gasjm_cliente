import 'package:flutter/services.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/registrar/registrar_controller.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:get/get.dart';

class FormRegistrar extends StatelessWidget {
  const FormRegistrar({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrarController>(
      builder: (_) => LayoutBuilder(
        builder: (context, constraint) {
          return Padding(
              padding: EdgeInsets.only(bottom: constraint.maxHeight * .1),
              child: Form(
                key: _.claveFormRegistrar,
                child: CustomScrollView(slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Registrar",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    color: AppTheme.blue,
                                    fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "Ingrese sus datos",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                              height: Responsive.getScreenSize(context).height *
                                  .05),
                          InputText(
                            iconPrefix: Icons.person_outlined,
                            keyboardType: TextInputType.name,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z]')),
                            ],
                            labelText: "Nombre",
                            controller: _.nombreTextoController,
                            validator: Validacion.validarNombre,
                          ),
                          SizedBox(
                              height: Responsive.getScreenSize(context).height *
                                  .02),
                          InputText(
                            iconPrefix: Icons.person_outlined,
                            keyboardType: TextInputType.name,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z]')),
                            ],
                            labelText: "Apellido",
                            controller: _.apellidoTextoController,
                            validator: Validacion.validarApellido,
                          ),
                          SizedBox(
                              height: Responsive.getScreenSize(context).height *
                                  .02),
                          InputText(
                            iconPrefix: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            labelText: "Correo electrónico",
                            controller: _.correoElectronicoTextoController,
                            validator: Validacion.validarCorreoElectronico,
                          ),
                          SizedBox(
                              height: Responsive.getScreenSize(context).height *
                                  .02),
                          Obx(
                            () => InputText(
                              iconPrefix: Icons.lock_outlined,
                              keyboardType: TextInputType.text,
                              obscureText: _.contrasenaOculta.value,
                              textInputAction: TextInputAction.done,
                              controller: _.contrasenaTextoController,
                              validator: Validacion.validarContrasena,
                              maxLines: 1,
                              labelText: "Contraseña",
                              suffixIcon: GestureDetector(
                                onTap: _.mostrarContrasena,
                                child: Icon(
                                  _.contrasenaOculta.value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppTheme.light,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: Responsive.getScreenSize(context).height *
                                  .02),
                          Obx(() => Visibility(
                              visible:
                                  _.errorParaCorreo.value?.isNotEmpty == true,
                              child: TextDescription(
                                text: _.errorParaCorreo.value ?? '',
                                color: Colors.red,
                              ))),

                          SizedBox(
                              height: Responsive.getScreenSize(context).height *
                                  .05),
                          Obx(() {
                            final estadoProceso = _.cargandoParaCorreo.value;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                PrimaryButton(
                                    texto: "Registrar",
                                    onPressed: () {
                                      if (_.claveFormRegistrar.currentState
                                              ?.validate() ==
                                          true) {
                                        _.registrarUsuario();
                                      }
                                    }),
                                if (estadoProceso) 
                              const CircularProgressIndicator(
                                  backgroundColor: Colors.white),
                              ],
                            );
                          }),
                          //
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .05),
/*
                          // Opcion para registrar con google
                          const TextDescription(text: "o registrar con"),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),

                          Obx(() {
                            final isSaving = _.cargandoParaSocialMedia.value;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // _.iniciarSesionConGoogle();
                                    _.registrarConGoogle();
                                  },
                                  child: const Image(
                                      image: AssetImage(
                                          "assets/icons/logogoogle.png"),
                                      height: 24.0),
                                ),
                                if (isSaving) const CircularProgressIndicator(),
                              ],
                            );
                          }),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),
                          Obx(() => Visibility(
                              visible:
                                  _.errorParaSocialMedia.value?.isNotEmpty ==
                                      true,
                              child: TextDescription(
                                text: _.errorParaSocialMedia.value ?? '',
                                color: Colors.red,
                              ))),
                          SizedBox(
                              height: Responsive.getScreenSize(context).height *
                                  .05),
                          const Expanded(
                              child: Divider(
                            color: Colors.white,
                          )),
                          */
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "¿Ya tienes una cuenta? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(color: Colors.black54),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.pushReplacementNamed(
                                        context, AppRoutes.identificacion)
                                  },
                                  child: Text(
                                    "Iniciar sesión",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                            color: AppTheme.blueDark,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                        ]),
                  ),
                ]),
              ));
        },
      ),
    );
  }
}
