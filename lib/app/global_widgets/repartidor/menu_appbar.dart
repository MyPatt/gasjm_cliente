import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/historial/historial_cliente.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get.dart';

//Barra de herramientas de opciones para la agenda y el historial
class MenuAppBar extends StatelessWidget {
  const MenuAppBar({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
        builder: (_) => Row(
              children: [
                //Opcion agenda
                IconButton(
                    //
                    // onPressed: showRatingDialog,calificarservicio
                    onPressed: _.cargarAgenda,
                    icon: const Icon(Icons.calendar_today_outlined)),
            
                //Opcion historial

                IconButton(
                    onPressed: () {
                      // Creamos una ruta
                      // recuerda que necesitamos del context proporcionado por el build
                      final route = MaterialPageRoute(builder: (context) {
                        return const TransactionPage();
                      });
                      // Usamos el método Navigator para ir a la página
                      // Este método requiere del contexto y la ruta
                      Navigator.push(context, route);
                    },
                    icon: const Icon(Icons.history_outlined)),
                const SizedBox(
                  width: 10,
                ),
              ],
            ));
  }
}
/**
 * 
    void showRatingDialog() {
      final ratingDialog = RatingDialog(
          title: const Text(
            "Calificar servicio",
            style: TextStyle(color: AppTheme.blueDark),
          ),
          message: const Text(
            "Seleccione la calificación del servicio ofrecido por el repartidor.",
            style: TextStyle(color: Colors.black45, fontSize: 14),
          ),
          commentHint: "Comentario",
          submitButtonText: 'Enviar',
          initialRating: 4,
          submitButtonTextStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(
                  color: AppTheme.blueBackground, fontWeight: FontWeight.w500),

          // ignore: avoid_print
          onCancelled: () => print('cancelled'),
          onSubmitted: (response) {
            // ignore: avoid_print
            print('rating: ${response.rating}, comment: ${response.comment}');
          });

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ratingDialog,
        ),
      );
    }
 */
