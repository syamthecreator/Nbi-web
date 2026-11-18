import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/app_logo.dart';

/// Desktop Hero Branding Section (Left 50vw Card with curved right edge).
class SignupDesktopHero extends StatelessWidget {
  const SignupDesktopHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF3EA), Color(0xFFFFE9DC)],
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(96),
          bottomRight: Radius.circular(96),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(255, 90, 0, 0.04),
            blurRadius: 32,
            offset: Offset(6, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(56, 48, 56, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppLogo(width: 88),
          const SizedBox(height: 28),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'School & College\n',
                  style: AppTypography.heading1(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111111),
                  ),
                ),
                TextSpan(
                  text: 'Communication',
                  style: AppTypography.heading1(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryOrange,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Text(
              'Bridging The Gap Between Institutions And Parents. Stay Informed, Stay Connected Grow Together.',
              style: AppTypography.subtitle(
                fontSize: 16.3,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF666666),
              ).copyWith(height: 1.5),
            ),
          ),

          const Spacer(),

          // 3D Illustration aligned to bottom
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 460),
              child: Image.asset(
                AppAssets.loginIllustration1,
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Mobile Hero Section.
class SignupMobileHero extends StatelessWidget {
  const SignupMobileHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF3EA), Color(0xFFFFE9DC)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AppLogo(width: 72),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'School & College ',
                  style: AppTypography.heading1(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111111),
                  ),
                ),
                TextSpan(
                  text: 'Communication',
                  style: AppTypography.heading1(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryOrange,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bridging The Gap Between Institutions And Parents.',
            textAlign: TextAlign.center,
            style: AppTypography.subtitle(
              fontSize: 14,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}
