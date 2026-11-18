import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/app_logo.dart';
import '../providers/institution_provider.dart';

/// Top peach hero section with brand, search pill, and illustration.
class InstitutionSearchHero extends StatelessWidget {
  final InstitutionProvider instProvider;
  final bool isDesktop;

  const InstitutionSearchHero({
    super.key,
    required this.instProvider,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFEF8F5),
        border: Border(bottom: BorderSide(color: Color(0xFFFFE4D6), width: 1.2)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1140),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48 : 20,
              vertical: isDesktop ? 36 : 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mini Logo Row
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

                // Hero Content Row (Left Search + Right Illustration)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Step Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE4D6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Step 1 of 2',
                              style: AppTypography.caption(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFD94800),
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
                          const SizedBox(height: 8),

                          Text(
                            'Search and follow your school or college to receive real-time updates and notices.',
                            style: AppTypography.subtitle(
                              fontSize: 15,
                              color: const Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Search Pill Input Box
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(color: const Color(0xFFFF8C42), width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF5A00).withValues(alpha: 0.08),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                const Icon(Icons.search, color: AppColors.primaryOrange, size: 22),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    onChanged: instProvider.updateSearch,
                                    cursorColor: AppColors.primaryOrange,
                                    style: AppTypography.bodyMedium(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF111111),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Search by institution name, location, city, or pincode...',
                                      hintStyle: AppTypography.bodyMedium(
                                        fontSize: 14.5,
                                        color: const Color(0xFF999999),
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                      fillColor: Colors.transparent,
                                      filled: false,
                                    ),
                                  ),
                                ),
                                if (instProvider.searchQuery.isNotEmpty)
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 18, color: Color(0xFF888888)),
                                    onPressed: () => instProvider.updateSearch(''),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isDesktop) ...[
                      const SizedBox(width: 48),
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          AppAssets.loginIllustration1,
                          height: 220,
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
