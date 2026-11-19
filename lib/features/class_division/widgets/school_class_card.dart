import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../models/class_division_model.dart';

/// Card showing school configuration with Class pills and Division circles.
class SchoolClassCard extends StatefulWidget {
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
  State<SchoolClassCard> createState() => _SchoolClassCardState();
}

class _SchoolClassCardState extends State<SchoolClassCard> {
  final ValueNotifier<bool> _isCardHovered = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isCardHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final school = widget.school;
    final isConfigured = school.isConfigured;

    return MouseRegion(
      onEnter: (_) => _isCardHovered.value = true,
      onExit: (_) => _isCardHovered.value = false,
      cursor: SystemMouseCursors.basic,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isCardHovered,
        builder: (context, isHovered, _) {
          // Border color
          final Color borderColor;
          if (isConfigured) {
            borderColor = const Color(0xFFFF8C42);
          } else if (isHovered) {
            borderColor = const Color(0xFFFFC099);
          } else {
            borderColor = const Color(0xFFEDEDED);
          }

          // Box shadow
          final List<BoxShadow> boxShadows;
          if (isConfigured) {
            boxShadows = [
              BoxShadow(
                color: const Color(0xFFFF5A00).withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ];
          } else if (isHovered) {
            boxShadows = [
              BoxShadow(
                color: const Color(0xFFFF5A00).withValues(alpha: 0.06),
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
              isHovered && !isConfigured ? -2.0 : 0.0,
              0,
            ),
            padding: const EdgeInsets.fromLTRB(28, 28, 26, 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderColor, width: 1.5),
              boxShadow: boxShadows,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Row: Crest + Name + Subtitle
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFEDEDED)),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x08000000), // rgba(0,0,0,0.03)
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          school.crestAsset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            school.name,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF111111),
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Setup details for students enrolled here.',
                            style: GoogleFonts.inter(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Card Section Divider
                const SizedBox(height: 20),
                const Divider(color: Color(0xFFEEEEEE), height: 1),
                const SizedBox(height: 22),

                // SELECT CLASS SECTION
                Text(
                  'SELECT CLASS',
                  style: GoogleFonts.montserrat(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF888888),
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 12),

                // SELECT CLASS Pills Row
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: school.classes.map((cls) {
                    final isSelected = school.selectedClass == cls;
                    return _ClassPillButton(
                      label: cls,
                      isSelected: isSelected,
                      onTap: () => widget.onSelectClass(cls),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 22),

                // SELECT DIVISION SECTION
                Text(
                  'SELECT DIVISION',
                  style: GoogleFonts.montserrat(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF888888),
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 12),

                // SELECT DIVISION Circles Row
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: school.divisions.map((div) {
                    final isSelected = school.selectedDivision == div;
                    return _DivisionCircleButton(
                      label: div,
                      isSelected: isSelected,
                      onTap: () => widget.onSelectDivision(div),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Class Pill Button
class _ClassPillButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ClassPillButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_ClassPillButton> createState() => _ClassPillButtonState();
}

class _ClassPillButtonState extends State<_ClassPillButton> {
  final ValueNotifier<bool> _isHovered = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _isHovered.value = true,
      onExit: (_) => _isHovered.value = false,
      cursor: SystemMouseCursors.click,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isHovered,
        builder: (context, isHovered, _) {
          final isSelected = widget.isSelected;

          final Color bgColor;
          final Color borderColor;
          final Color textColor;
          final List<BoxShadow>? boxShadows;

          if (isSelected) {
            bgColor = const Color(0xFFFFF0E6);
            borderColor = const Color(0xFFFF8C42);
            textColor = AppColors.primaryOrange;
            boxShadows = [
              BoxShadow(
                color: const Color(0xFFFF5A00).withValues(alpha: 0.10),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ];
          } else if (isHovered) {
            bgColor = const Color(0xFFFFFDFB);
            borderColor = const Color(0xFFFFC099);
            textColor = const Color(0xFF333333);
            boxShadows = null;
          } else {
            bgColor = Colors.white;
            borderColor = const Color(0xFFE5E7EB);
            textColor = const Color(0xFF333333);
            boxShadows = null;
          }

          return GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              height: 42,
              constraints: const BoxConstraints(minWidth: 48),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor, width: 1.5),
                boxShadow: boxShadows,
              ),
              child: Center(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Text(
                  widget.label,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Division Circle Button
class _DivisionCircleButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DivisionCircleButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_DivisionCircleButton> createState() => _DivisionCircleButtonState();
}

class _DivisionCircleButtonState extends State<_DivisionCircleButton> {
  final ValueNotifier<bool> _isHovered = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _isHovered.value = true,
      onExit: (_) => _isHovered.value = false,
      cursor: SystemMouseCursors.click,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isHovered,
        builder: (context, isHovered, _) {
          final isSelected = widget.isSelected;

          final Color bgColor;
          final Color borderColor;
          final double borderWidth;
          final Color textColor;
          final List<BoxShadow>? boxShadows;

          if (isSelected) {
            bgColor = const Color(0xFFFFF0E6);
            borderColor = const Color(0xFFFF8C42);
            borderWidth = 2.0;
            textColor = AppColors.primaryOrange;
            boxShadows = [
              BoxShadow(
                color: const Color(0xFFFF5A00).withValues(alpha: 0.10),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ];
          } else if (isHovered) {
            bgColor = const Color(0xFFFFFDFB);
            borderColor = const Color(0xFFFFC099);
            borderWidth = 1.5;
            textColor = const Color(0xFF333333);
            boxShadows = null;
          } else {
            bgColor = Colors.white;
            borderColor = const Color(0xFFE5E7EB);
            borderWidth = 1.5;
            textColor = const Color(0xFF333333);
            boxShadows = null;
          }

          return GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: borderWidth),
                boxShadow: boxShadows,
              ),
              child: Center(
                child: Text(
                  widget.label,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
