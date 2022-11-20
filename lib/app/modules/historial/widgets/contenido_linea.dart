import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class ContenidoLinea extends StatelessWidget {
  const ContenidoLinea(this.index, this.context, {Key? key}) : super(key: key);
  final int index;
 final BuildContext context;
  @override
  Widget build( context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: AppTheme.blueBackground,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
                color: AppTheme.blueBackground, shape: BoxShape.circle),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: AppTheme.blueBackground,
            ),
          ),
        ],
      ),
    );
  }
}
