import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../models/class_division_model.dart';

/// Card showing school configuration with Class pills and Division circles.
class SchoolClassCard extends StatelessWidget {
  final SchoolConfigModel school;
  final ValueChanged<String> onSelectClass;
  final ValueChanged<String> onSelectDivision;

  const SchoolClassCard({
    super.key,
    required this.school,
    required this.onSelectClass,
    required this.onSelectDivision,
  });

  @override
  Widget build(BuildContext context) {
    final isConfigured = school.isConfigured;

    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isConfigured ? const Color(0xFFFF8C42) : const Color(0xFFEDEDED),
          width: isConfigured ? 1.8 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isConfigured
                ? const Color(0xFFFF5A00).withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Crest + Name + Subtitle
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFEDEDED)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(4),
                child: Image.asset(school.crestAsset, fit: BoxFit.contain),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      school.name,
                      style: AppTypography.heading3(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Setup details for students enrolled here.',
                      style: AppTypography.caption(
                        fontSize: 13,
                        color: const Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFFEEEEEE), height: 1),
          const SizedBox(height: 18),

          // SELECT CLASS SECTION
          Text(
            'SELECT CLASS',
            style: AppTypography.caption(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF888888),
            ).copyWith(letterSpacing: 0.6),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: school.classes.map((cls) {
              final isSelected = school.selectedClass == cls;
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => onSelectClass(cls),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFFF0E6) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? const Color(0xFFFF8C42) : const Color(0xFFE5E7EB),
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFFFF5A00).withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cls,
                    style: AppTypography.caption(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected ? AppColors.primaryOrange : const Color(0xFF333333),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // SELECT DIVISION SECTION
          Text(
            'SELECT DIVISION',
            style: AppTypography.caption(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF888888),
            ).copyWith(letterSpacing: 0.6),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: school.divisions.map((div) {
              final isSelected = school.selectedDivision == div;
              return InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: () => onSelectDivision(div),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? const Color(0xFFFFF0E6) : Colors.white,
                    border: Border.all(
                      color: isSelected ? const Color(0xFFFF8C42) : const Color(0xFFE5E7EB),
                      width: isSelected ? 2.0 : 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFFFF5A00).withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    div,
                    style: AppTypography.bodyBold(
                      fontSize: 14,
                      color: isSelected ? AppColors.primaryOrange : const Color(0xFF333333),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
