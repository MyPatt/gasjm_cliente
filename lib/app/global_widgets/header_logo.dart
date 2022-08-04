import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:gasjm/app/core/theme/app_theme.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 96.0,
            width: 96.0,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              //foregroundColor: this.foregroundColor,

              child: Container(
                  height: 85,
                  child: const Image(
                    image: AssetImage("assets/icons/logogasjm.png"),
                  )),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
                width: 1.0,
              ),
              shape: BoxShape.circle,
              //image: DecorationImage(image: this.logo)
            ),
          ),
        ],
      ),
    );
  }
}
