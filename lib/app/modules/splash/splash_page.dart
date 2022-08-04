import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gasjm/app/modules/splash/splash_controller.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';

import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (_) => Scaffold(
        backgroundColor: AppTheme.blueBackground,
        // ignore: sized_box_for_whitespace
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/camiongas.svg",
                height: 96.0,
                width: 96.0,
              ),
              RichText(
                text: TextSpan(
                  text: "Gas",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: AppTheme.blueDark, fontWeight: FontWeight.w900),
                  children: [
                    TextSpan(
                      text: "J&M",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Responsive.getScreenSize(context).height * .02),
              // ignore: sized_box_for_whitespace
              Container(
                width: Responsive.getScreenSize(context).height * .05,
                child: const LinearProgressIndicator(
                  backgroundColor: AppTheme.blueDark,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
