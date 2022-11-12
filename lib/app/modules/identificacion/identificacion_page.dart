import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/identificacion/identificacion_controller.dart';
import 'package:gasjm/app/modules/identificacion/widgets/content.dart';
import 'package:get/get.dart';

class IdentificacionPage extends StatelessWidget {
  const IdentificacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IdentificacionController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: const Contenido(),
            ),
          ),
        ),
      ),
    );
  }
}
