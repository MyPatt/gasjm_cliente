import 'package:flutter/material.dart'; 
import 'package:gasjm/app/core/theme/app_theme.dart'; 

import 'package:gasjm/app/modules/ubicacion/ubicacion_controller.dart';
import 'package:gasjm/app/modules/ubicacion/widgets/content.dart';
import 'package:get/get.dart';

class UbicacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UbicacionController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
         
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: Content(),
              /* child: Center(child:Content()
                 
                    BlocBuilder<GpsBloc, GpsState>(builder: (context, state) {
                  return !state.isGpsEnabled
                      ? Content()
                      : const _EnableGpsMessage();
                })
               )
                */
            ),
          ),
        ),
      ),
    );
  }
}
 