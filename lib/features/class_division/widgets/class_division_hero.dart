import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';

/// Top hero section for Class & Division selection (Step 2 of 2)
class ClassDivisionHero extends StatelessWidget {
  final bool isDesktop;

  const ClassDivisionHero({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFEF8F5),
        border: Border(
          bottom: BorderSide(color: Color(0xFFF2E8E2), width: 1.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000), // rgba(0,0,0,0.04)
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Navigation Header
          Container(
            width: double.infinity,
            height: 72,
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    AppAssets.logo,
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                    children: const [
                      TextSpan(
                        text: 'Notice Board ',
                        style: TextStyle(color: AppColors.primaryOrange),
                      ),
                      TextSpan(
                        text: 'India',
                        style: TextStyle(color: Color(0xFF111111)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Hero Banner Section
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1380),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 40 : 18,
                  vertical: isDesktop ? 16 : 12,
                ).copyWith(bottom: isDesktop ? 28 : 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Column: Step Tag, Heading & Subtitle
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Step Badg
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF0E6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Step 2 of 2',
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryOrange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Heading
                          Text(
                            'Find Your Educational Institutions',
                            style: GoogleFonts.montserrat(
                              fontSize: isDesktop ? 37 : 24,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF111111),
                              height: 1.18,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Subtitle
                          Text(
                            "Search for your child's school to get started.",
                            style: GoogleFonts.inter(
                              fontSize: isDesktop ? 16 : 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF666666),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Right Column: School Building Illustration
                    if (isDesktop) ...[
                      const SizedBox(width: 32),
                      Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 260),
                            child: Image.asset(
                              AppAssets.loginIllustration2,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
