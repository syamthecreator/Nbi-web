import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/hover_builder.dart';
import '../models/institution_model.dart';

/// Institution Card
/// Features 1:1 CSS hover states: translateY(-2px), border #FFC099, box-shadow.
class InstitutionCard extends StatelessWidget {
  final InstitutionModel institution;
  final VoidCallback onToggleFollow;

  const InstitutionCard({
    super.key,
    required this.institution,
    required this.onToggleFollow,
  });

  @override
  Widget build(BuildContext context) {
    final isFollowing = institution.isFollowing;

    return HoverBuilder(
      builder: (context, isHovered) {
        // Border color institution-card:hover / .is-following
        final Color borderColor;
        if (isFollowing) {
          borderColor = const Color(0xFFFF8C42);
        } else if (isHovered) {
          borderColor = const Color(0xFFFFC099);
        } else {
          borderColor = const Color(0xFFEDEDED);
        }

        // Box shadow
        final List<BoxShadow> boxShadows;
        if (isFollowing) {
          boxShadows = [
            BoxShadow(
              color: const Color(0xFFFF5A00).withValues(alpha: 0.10),
              blurRadius: 28,
              offset: const Offset(0, 4),
            ),
          ];
        } else if (isHovered) {
          boxShadows = [
            BoxShadow(
              color: const Color(0xFFFF5A00).withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ];
        } else {
          boxShadows = [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ];
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: const Cubic(0.16, 1, 0.3, 1),
          transform: Matrix4.translationValues(
            0,
            isHovered && !isFollowing ? -2.0 : 0.0,
            0,
          ),
          padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: boxShadows,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Row: 68x68 Crest Logo Box + Name + Location
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFEDEDED),
                        width: 1,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        institution.crestAsset,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          institution.name,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF111111),
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Color(0xFF888888),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                institution.location,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF666666),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Spacing to button
              const SizedBox(height: 20),

              // Follow / Following Full-Width Button
              HoverBuilder(
                cursor: SystemMouseCursors.click,
                builder: (context, isBtnHovered) {
                  return SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: onToggleFollow,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          transform: Matrix4.translationValues(
                            0,
                            isBtnHovered && !isFollowing ? -1.0 : 0.0,
                            0,
                          ),
                          decoration: BoxDecoration(
                            color: isFollowing
                                ? (isBtnHovered
                                      ? const Color(0xFFFFE5D4)
                                      : const Color(0xFFFFF0E6))
                                : null,
                            gradient: isFollowing
                                ? null
                                : (isBtnHovered
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFFE05300),
                                            Color(0xFFE03B00),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : const LinearGradient(
                                          colors: [
                                            Color(0xFFFF6000),
                                            Color(0xFFFF4500),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )),
                            borderRadius: BorderRadius.circular(12),
                            border: isFollowing
                                ? Border.all(
                                    color: const Color(0xFFFF8C42),
                                    width: 1.5,
                                  )
                                : null,
                            boxShadow: isFollowing
                                ? null
                                : [
                                    BoxShadow(
                                      color: const Color(0xFFFF5A00).withValues(
                                        alpha: isBtnHovered ? 0.32 : 0.22,
                                      ),
                                      blurRadius: isBtnHovered ? 20 : 16,
                                      offset: Offset(0, isBtnHovered ? 8 : 6),
                                    ),
                                  ],
                          ),
                          child: Center(
                            child: isFollowing
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Following',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryOrange,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.check,
                                        size: 18,
                                        color: AppColors.primaryOrange,
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Follow School',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '+',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
