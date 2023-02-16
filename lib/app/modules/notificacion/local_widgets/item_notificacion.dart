import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';

class ItemNotificacion extends StatelessWidget {
  const ItemNotificacion({
    Key? key,
    required this.notificacion,required this.onTap,
  }) : super(key: key);

  final String notificacion;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0), color: Colors.white),
          padding:
              const EdgeInsets.only(right: 8.0, left: 8.0, top: 0.0, bottom: 0.0),
          child: Row(
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppTheme.blueDark,
                  ),
                  Column(children: [
                    Row(
                      children: [
                        TextSubtitle(
                            text: notificacion.split(',')[0],
                            color: Colors.black38),
                        //   TextDescription(text: e.split(',')[1]),
                        Text(
                          notificacion.split(',')[1],
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.black38,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          notificacion.split(',')[2],
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.black38,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ]),
                ],
              ),
            ],
          )),
    );
  }
}
