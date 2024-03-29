import 'package:flutter/material.dart'; 
import 'package:gasjm/app/modules/ubicacion/widgets/content.dart'; 
class UbicacionPage extends StatelessWidget {
  const UbicacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: const Content(),
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
    );
  }
}
