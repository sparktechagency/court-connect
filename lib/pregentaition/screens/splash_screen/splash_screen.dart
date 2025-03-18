import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/custom_assets/assets.gen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: 0,
              right: -44.w,
              child: Assets.images.splashTop.image()),
          Center(
            child: Assets.images.logo.image(),
          ),
          Positioned(
            left: -44.w,
            bottom: 0,
              child: Assets.images.splashBottom.image()),
        ],
      ),
    );
  }
}
