import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';

//Muestra un dialogo modal con las opciones si o no
class ModalAlert extends StatelessWidget {
  const ModalAlert(
      {Key? key,
      required this.titulo,
      required this.mensaje,
      required this.onPressed,
      this.icono})
      : super(key: key);
  final String titulo;
  final String mensaje;
  final void Function() onPressed;
  final IconData? icono;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: TextSubtitle(
        text: titulo,
        textAlign: TextAlign.justify,
        //   style: TextoTheme.subtitleStyle2,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: AppTheme.light,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  icono,
                  color: AppTheme.blueBackground,
                  size: 50,
                ),
                radius: 55.0,
              ),
              radius: 56.0,
            ),
            SizedBox(height: Responsive.getScreenSize(context).height * .05),
            TextDescription(text: mensaje),
          ],
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            const Divider(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    child: const Text(
                      'No',
                      style: TextStyle(
                          color: Colors.black38, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => Navigator.of(context).pop()),
                TextButton(
                  child: const Text(
                    'Si ',
                    style: TextStyle(
                        color: AppTheme.blueBackground,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: onPressed,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
