import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../models/role_item_model.dart';

/// Interactive Role Selection Card with radio checkmark and category badge.
class RoleCard extends StatelessWidget {
  final RoleItemModel model;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.model,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? null : Colors.white,
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFF8F3), Color(0xFFFFF0E6)],
                )
              : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryOrange
                : const Color(0xFFEDEDED),
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFFF5A00).withValues(alpha: 0.14),
                    blurRadius: 30,
                    offset: const Offset(0, 14),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            // Top Right Checkmark Badge - 14px from top and right of the card border
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primaryOrange : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryOrange
                        : const Color(0xFFD0D0D0),
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? const Center(
                        child: Icon(Icons.check, size: 13, color: Colors.white),
                      )
                    : null,
              ),
            ),

            // Card Content - All Center Aligned with exact padding matching select-role.css
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Role Circular Icon (64x64)
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: model.iconBgColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            model.icon,
                            color: model.iconColor,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Role Title - Center Aligned
                      Text(
                        model.title,
                        style: AppTypography.heading3(
                          fontSize: 18.4,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111111),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      // Description - Center Aligned with Inter font (matching select-role.css)
                      ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 46),
                        child: Center(
                          child: Text(
                            model.description,
                            style: GoogleFonts.inter(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF666666),
                              height: 1.45,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Role Tag - Center Aligned (pinned to bottom with equal baseline)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: model.tagBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      model.tagText,
                      style: GoogleFonts.inter(
                        fontSize: 12.2,
                        fontWeight: FontWeight.w700,
                        color: model.tagColor,
                        letterSpacing: 0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
