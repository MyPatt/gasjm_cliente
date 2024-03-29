import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/header_logo.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/login/login_controller.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/validaciones.dart';
import 'package:get/get.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) => LayoutBuilder(builder: (context, constraint) {
        return Padding(
          padding: EdgeInsets.only(bottom: constraint.maxHeight * .1),
          child: Obx(
            () => AbsorbPointer(
              absorbing: _.cargandoParaCorreo.value,
              child: Form(
                key: _.formKey,
                child: CustomScrollView(slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const HeaderLogo(),
                        SizedBox(
                            height:
                                Responsive.getScreenSize(context).height * .05),
                        //////
                        Text(
                          "Iniciar sesión",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: AppTheme.blue,
                                  fontWeight: FontWeight.w900),
                        ),
                        const TextDescription(text: "Ingrese su contraseña"),
                        SizedBox(
                            height:
                                Responsive.getScreenSize(context).height * .05),

                        GestureDetector(
                          onTap: () => _.obtenerCorreo(),
                          child: InputText(
                            controller: _.correoTextoController,
                            iconPrefix: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            //readOnly: true,
                            validator: Validacion.validarCorreoElectronico,
                            labelText: "Correo electrónico",
                            enabled: false,
                          ),
                        ),

                        SizedBox(
                            height:
                                Responsive.getScreenSize(context).height * .02),
                        Obx(
                          () => InputText(
                            controller: _.contrasenaTextoController,
                            iconPrefix: Icons.lock_outlined,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            obscureText: _.contrasenaOculta.value,
                            autofocus: true,
                            maxLines: 1,
                            validator: Validacion.validarContrasena,
                            labelText: "Contraseña",
                            filled: false,
                            /* */
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
                            height:
                                Responsive.getScreenSize(context).height * .02),
                        Obx(() => Visibility(
                            visible:
                                _.errorParaCorreo.value?.isNotEmpty == true,
                            child: TextDescription(
                              text: _.errorParaCorreo.value ?? '',
                              color: Colors.red,
                            ))),
                        SizedBox(
                            height:
                                Responsive.getScreenSize(context).height * .05),

                        //
                        Obx(() {
                          final estadoProceso = _.cargandoParaCorreo.value;
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Visibility(
                                visible: !_.cargandoParaCorreo.value,
                                child: PrimaryButton(
                                  texto: "Iniciar sesión",
                                  onPressed: () {
                                    if (_.formKey.currentState?.validate() ==
                                        true) {
                                      
                                      _.iniciarSesionConCorreoYContrasena();
                                    }
                                  },
                                ),
                              ),
                              if (estadoProceso) const CircularProgress(),
                            ],
                          );
                        }),

                        SizedBox(
                            height:
                                Responsive.getScreenSize(context).height * .05),
                        /*  const Expanded(
                            child: Divider(
                          color: Colors.white,
                        )),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Contraseña olvidada",
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
                                "Crear una cuenta",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(
                                        color: AppTheme.blueDark,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      }),
    );
  }
}
