import 'package:vector_graphics/vector_graphics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture(
          AssetBytesLoader(Constants.appLogo),
          height: 100,
        ),
        Text(Constants.appName,
            style: Theme.of(context).textTheme.displayLarge),
      ],
    );
  }
}
