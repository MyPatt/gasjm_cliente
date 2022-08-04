import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasjm/app/modules/ubicacion/blocs/blocs.dart';
import 'package:gasjm/app/modules/ubicacion/ubicacion_page.dart';

class GpsAccessPage extends StatelessWidget {
  const GpsAccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: BlocBuilder<GpsBloc, GpsState>(builder: (context, state) {
      
        return !state.isGpsEnabled
            ? const _EnableGpsMessage()
            : UbicacionPage();
      })),
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Debe de habilitar el GPS',
    );
  }
}
