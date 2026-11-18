import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/app_logo.dart';

class SplashLogoView extends StatelessWidget {
  const SplashLogoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppLogo(width: 380),
        const SizedBox(height: 32),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'NOTICE BOARD ',
                  style: AppTypography.splashTitle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                  ).copyWith(color: AppColors.primaryOrange),
                ),
                TextSpan(
                  text: 'INDIA',
                  style: AppTypography.splashTitle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                  ).copyWith(color: AppColors.textDark),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
