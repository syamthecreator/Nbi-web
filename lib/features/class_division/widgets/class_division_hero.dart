import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/app_logo.dart';

/// Top hero section for Class & Division selection.
class ClassDivisionHero extends StatelessWidget {
  final bool isDesktop;

  const ClassDivisionHero({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFEF8F5),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: 24,
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const AppLogo(width: 44),
                    const SizedBox(width: 12),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Notice Board ',
                            style: AppTypography.heading3(
                              fontSize: 18,
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: 'India',
                            style: AppTypography.heading3(
                              fontSize: 18,
                              color: const Color(0xFF111111),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF0E6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Step 2 of 2',
                              style: AppTypography.caption(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryOrange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Find Your Educational Institutions',
                            style: AppTypography.heading1(
                              fontSize: isDesktop ? 34 : 24,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF111111),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Search for your child's school to get started.",
                            style: AppTypography.subtitle(
                              fontSize: 15,
                              color: const Color(0xFF555555),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isDesktop) ...[
                      const SizedBox(width: 32),
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          AppAssets.loginIllustration1,
                          height: 180,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
