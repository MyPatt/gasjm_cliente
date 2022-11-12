import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';

abstract class ProgressDialog {
  static void show(BuildContext context, String texto) {
    showCupertinoDialog(
      context: context,
      builder: (_) => WillPopScope(
          child: Container(
              width: double.infinity,
              height: Responsive.hp(context),
              color: AppTheme.blueBackground,
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const CircularProgressIndicator(
                      color: AppTheme.blueDark,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .02),
                    Text(texto,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ])),
          onWillPop: () async => false),
    );
  }
}
