import 'package:flutter/material.dart';
import '../constants/app_assets.dart';

class BackgroundShapes extends StatelessWidget {
  final bool showTopLeft;
  final bool showTopRight;
  final bool showBottomLeft;
  final bool showBottomRight;

  const BackgroundShapes({
    super.key,
    this.showTopLeft = false,
    this.showTopRight = false,
    this.showBottomLeft = false,
    this.showBottomRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final shapeWidthTopRight = (size.width * 0.24).clamp(120.0, 320.0);
    final shapeWidthBottomLeft = (size.width * 0.26).clamp(130.0, 340.0);

    return IgnorePointer(
      child: Stack(
        children: [
          // Top Left (used in Splash index.html)
          if (showTopLeft)
            Positioned(
              top: 0,
              left: 0,
              width: (size.width * 0.22).clamp(160.0, 320.0),
              child: Image.asset(
                AppAssets.splash1,
                alignment: Alignment.topLeft,
                fit: BoxFit.contain,
              ),
            ),

          // Top Right (used in select-role.html, signup.html with scaleX(-1))
          if (showTopRight)
            Positioned(
              top: 0,
              right: 0,
              width: shapeWidthTopRight,
              child: Transform.flip(
                flipX: true,
                child: Image.asset(
                  AppAssets.splash1,
                  alignment: Alignment.topRight,
                  fit: BoxFit.contain,
                ),
              ),
            ),

          // Bottom Left (used in select-role.html with Splash-2.png scaleX(-1))
          if (showBottomLeft)
            Positioned(
              bottom: 0,
              left: 0,
              width: shapeWidthBottomLeft,
              child: Transform.flip(
                flipX: true,
                child: Image.asset(
                  AppAssets.splash2,
                  alignment: Alignment.bottomLeft,
                  fit: BoxFit.contain,
                ),
              ),
            ),

          // Bottom Right (used in Splash index.html)
          if (showBottomRight)
            Positioned(
              bottom: 0,
              right: 0,
              width: (size.width * 0.22).clamp(160.0, 320.0),
              child: Image.asset(
                AppAssets.splash2,
                alignment: Alignment.bottomRight,
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
    );
  }
}
