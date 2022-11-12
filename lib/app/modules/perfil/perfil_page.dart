import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/modules/perfil/widgets/contenido_perfil.dart';
import 'package:gasjm/app/modules/perfil/perfil_controller.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class PerfilPage extends StatelessWidget {
  PerfilPage({key}) : super(key: key);
  final PerfilController controladorDePedidos = Get.put(PerfilController());
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
          leading: BackButton(
            //color: AppTheme.blueDark,
            onPressed: () {
              Get.offNamed(AppRoutes.inicio);
            },
          ),
          backgroundColor: AppTheme.blueBackground,
          // actions: const [MenuAppBar(

          title: const Text('Mi cuenta'),
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: Responsive.hp(context) * 0.90,
                child: const PerfilUsuario()),
          ),
        ),
      ),
    );
  }
}
