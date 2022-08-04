import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:gasjm/app/global_widgets/dialogs/progress_dialog.dart';
import 'package:gasjm/app/global_widgets/repartidor/menu_controller.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';

import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

//Menú deslizable a la izquierda con opciones del  usuario
class MenuLateral extends StatelessWidget {
  MenuLateral({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(
      builder: (_) => Drawer(
          child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildDrawerHeader(),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                Get.find<AutenticacionController>()
                        .autenticacionUsuario
                        .value
                        ?.nombre ??
                    "Usuario",
                style: const TextStyle(
                    color: AppTheme.blueDark, fontWeight: FontWeight.w500),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                _.usuario.value?.perfil ?? 'Cliente',
                style: const TextStyle(color: Colors.black38),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            _buildDrawerItem(
                icon: Icons.person_outline,
                text: 'Mi cuenta',
                onTap: () => {
                      Navigator.pushReplacementNamed(context, AppRoutes.agenda)
                    }),
            _buildDrawerItem(
                icon: Icons.message_outlined,
                text: 'Mensajes',
                onTap: () => {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.identificacion)
                    }),
            _buildDrawerItem(
                icon: Icons.settings_outlined,
                text: 'Configuración',
                onTap: () => {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.ubicacion)
                    }),
            _buildDrawerItem(
                icon: Icons.help_outline,
                text: 'Ayuda',
                onTap: () => {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.registrar)
                    }),
            _buildDrawerItem(
              icon: Icons.exit_to_app_outlined,
              text: 'Cerrar sesión',
              onTap: () {
                ProgressDialog.show(context, "Cerrando sesión");

                Get.find<AutenticacionController>().cerrarSesion();
              },
            ),
            ListTile(
              title: const Text(
                'v: 1.0.0',
                style: TextStyle(color: Colors.black38),
              ),
              onTap: () {},
            ),
          ],
        ),
      )),
    );
  }
}

Widget _buildDrawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide.none, top: BorderSide.none)),
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 48),
          height: 150,
          decoration: const BoxDecoration(
            color: AppTheme.blueBackground,
            border: Border(bottom: BorderSide.none, top: BorderSide.none),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            child: CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12.0,
                    child: Icon(
                      Icons.camera_alt,
                      size: 15.0,
                      color: Color(0xFF404040),
                    ),
                  ),
                ),
                radius: 38.0,
                backgroundImage: NetworkImage(
                    'https://i.picsum.photos/id/1005/5760/3840.jpg?hmac=2acSJCOwz9q_dKtDZdSB-OIK1HUcwBeXco_RMMTUgfY'),
              ),
            ),
          ),
        ),
      ]));
}

Widget _buildDrawerItem(
    {IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.black38,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text!,
            style: const TextStyle(color: Colors.black38),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
