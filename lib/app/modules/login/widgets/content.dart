import 'package:flutter/material.dart';
import 'form_login.dart';

class Content extends StatelessWidget {
  const Content({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const FormLogin(),
    );
  }
}
