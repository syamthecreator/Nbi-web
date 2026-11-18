import 'package:flutter/material.dart';
import '../constants/app_assets.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double? height;

  const AppLogo({
    super.key,
    this.width = 440,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logo,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
