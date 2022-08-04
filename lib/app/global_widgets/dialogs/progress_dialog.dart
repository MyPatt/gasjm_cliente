import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';

abstract class ProgressDialog {
  static void show(BuildContext context, String texto) {
    showCupertinoDialog(
      context: context,
      builder: (_) => WillPopScope(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black12,
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const CircularProgressIndicator(
                      color: AppTheme.blueBackground,
                      backgroundColor: Colors.white, 
                    ),
                    TextDescription(
                      text: texto,
                      color: Colors.white,
                    )
                  ])),
          onWillPop: () async => false),
    );
  }
}
