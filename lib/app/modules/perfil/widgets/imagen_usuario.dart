import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/perfil/perfil_controller.dart';
import 'package:get/get.dart';

class ImagenUsuario extends StatelessWidget {
  ImagenUsuario({Key? key}) : super(key: key);
  final userController = Get.find<PerfilController>();

  @override
  Widget build(BuildContext context) {
    /*  final imageObx = Obx(() {
      Widget image = Image.asset(
        'assets/icons/profile.png',
        fit: BoxFit.fill,
      );

      if (userController.pickedImage.value != null) {
        image = Image.file(
          userController.pickedImage.value,
          fit: BoxFit.fill,
        );
      }
      else if (userController.user.value?.image?.isNotEmpty == true) {
        image = CachedNetworkImage(
          imageUrl: userController.user.value!.image!,
          progressIndicatorBuilder: (_, __, progress) =>
              CircularProgressIndicator(value: progress.progress),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
          fit: BoxFit.fill,
        );
      }
      return image;
    });*/
    return GetBuilder<PerfilController>(
      builder: (_) => Center(
        child: CircleAvatar(
          radius: 75.0,
          backgroundColor: AppTheme.light,
          child: CircleAvatar(
            radius: 74.50,
            backgroundColor: Colors.white,
            child: Obx(
              () => Stack(children: [
                buildImage(_.existeImagenPerfil.value, _.pickedImage.value,
                    _.usuario?.fotoPersona),
                Positioned(
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14.0,
                      child: IconButton(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3.0),
                        iconSize: 18.0,
                        icon: const Icon(
                          Icons.photo_camera,
                          color: AppTheme.light,
                        ),
                        onPressed: () {
                          _.cargarImagen();
                        },
                      )),
                  right: 5,
                  bottom: 5,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  // Builds Profile Image
  Widget buildImage(bool existeImagenPerfil, File? file, String? url) {
    final imagenInicio = existeImagenPerfil == true
        ? CircleAvatar(
            backgroundColor: AppTheme.light,
            radius: 70,
            backgroundImage: NetworkImage(url!))
        : const CircleAvatar(
            backgroundColor: AppTheme.light,
            radius: 70,
            child: CircleAvatar(
                backgroundColor: AppTheme.light,
                radius: 50,
                backgroundImage: AssetImage(
                  'assets/icons/placehoderperfil.png',
                )),
          );

    return file == null
        ? imagenInicio
        : CircleAvatar(
            backgroundColor: AppTheme.light,
            radius: 70,
            backgroundImage: FileImage(file));
  }
}
/*
 CircleAvatar(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 17.0,
                      child: IconButton(
                            iconSize: 20.0,
                      
                        icon:const Icon(
                          Icons.camera_alt,
                      
                          color: AppTheme.light,
                        ),  onPressed: () {
                          _.cargarImagen();
                        },
                      )),
                ),
                radius: 70.0,
                //backgroundImage:_.usuario.fotoPersona==null?  
               
                backgroundImage:   FileImage(_.pickedImage.value)
                /*_.pickedImage.value!=null?
                   FileImage(_.pickedImage.value!):
                 AssetImage(
                  'assets/icons/profile.png',
                ),*/
              ) */