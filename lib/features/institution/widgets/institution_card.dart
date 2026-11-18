import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../models/institution_model.dart';

/// Institution Card component matching source_nbi with 68x68 crest box and full-width Follow button.
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

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isFollowing ? const Color(0xFFFF8C42) : const Color(0xFFEDEDED),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isFollowing
                ? const Color(0xFFFF5A00).withValues(alpha: 0.10)
                : Colors.black.withValues(alpha: 0.02),
            blurRadius: isFollowing ? 24 : 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Row: 68x68 Crest Logo + Name + Location
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFEDEDED), width: 1),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(6),
                child: Image.asset(institution.crestAsset, fit: BoxFit.contain),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      institution.name,
                      style: AppTypography.heading3(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111111),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 15, color: Color(0xFF888888)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            institution.location,
                            style: AppTypography.caption(
                              fontSize: 13.5,
                              color: const Color(0xFF666666),
                              fontWeight: FontWeight.w500,
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

          const SizedBox(height: 20),

          // Pincode & City badges
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  institution.city,
                  style: AppTypography.caption(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4B5563),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  institution.pincode,
                  style: AppTypography.caption(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4B5563),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Full-Width Follow / Following Button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: isFollowing
                ? OutlinedButton(
                    onPressed: onToggleFollow,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryOrange, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: const Color(0xFFFFF2EB),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check, size: 16, color: AppColors.primaryOrange),
                        const SizedBox(width: 6),
                        Text(
                          'Following',
                          style: AppTypography.buttonText(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryOrange,
                          ),
                        ),
                      ],
                    ),
                  )
                : ElevatedButton(
                    onPressed: onToggleFollow,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFFF9FAFB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, size: 16, color: Color(0xFF374151)),
                        const SizedBox(width: 6),
                        Text(
                          'Follow',
                          style: AppTypography.buttonText(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
