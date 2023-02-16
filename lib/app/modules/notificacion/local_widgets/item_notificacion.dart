import 'package:flutter/material.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';

class ItemNotificacion extends StatelessWidget {
  const ItemNotificacion({
    Key? key,
    required this.notificacion,
    required this.onTap,
  }) : super(key: key);

  final String notificacion;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0), color: Colors.white),
          child: Row(children: <Widget>[
            Row(
              children: [
                TextSubtitle(text: notificacion.split(',')[0]),
                //   TextDescription(text: e.split(',')[1]),
                Text(
                  notificacion.split(',')[1],
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Colors.black38, fontWeight: FontWeight.normal),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  notificacion.split(',')[2],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black38, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ])),
    );
  }
}
