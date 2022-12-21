import 'package:flutter/material.dart';

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
            child: const CircleAvatar(
              backgroundImage: AssetImage("assets/icons/gasjm.png"),
              radius: 50,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
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
