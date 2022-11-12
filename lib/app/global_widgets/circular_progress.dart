import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class CircularProgress extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CircularProgress();
  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: Colors.white,
      color: AppTheme.blueBackground,
    );
  }
}
