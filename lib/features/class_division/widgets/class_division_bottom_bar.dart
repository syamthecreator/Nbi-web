import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/hover_builder.dart';
import '../providers/class_division_provider.dart';

/// Sticky bottom action bar for Class & Division screen (Step 2)
class ClassDivisionBottomBar extends StatelessWidget {
  const ClassDivisionBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClassDivisionProvider>(
      builder: (context, cdProvider, _) {
        final isAllConfigured = cdProvider.isAllConfigured;

        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Color(0xFFEAEAEA), width: 1.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000), // rgba(0,0,0,0.08)
                blurRadius: 24,
                offset: Offset(0, -6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1380),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Status Text
                  Text(
                    isAllConfigured
                        ? 'Class and division setup complete for all schools'
                        : 'Class and division setup in progress',
                    style: GoogleFonts.montserrat(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryOrange,
                    ),
                  ),

                  // Next Button
                  HoverBuilder(
                    cursor: SystemMouseCursors.click,
                    builder: (context, isHovered) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.schoolFeed);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            height: 50,
                            constraints: const BoxConstraints(minWidth: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            transform: Matrix4.translationValues(
                              0,
                              isHovered ? -2.0 : 0.0,
                              0,
                            ),
                            decoration: BoxDecoration(
                              gradient: isHovered
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
                                    ),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFFF5A00,
                                  ).withValues(alpha: isHovered ? 0.38 : 0.28),
                                  blurRadius: isHovered ? 24 : 18,
                                  offset: Offset(0, isHovered ? 10 : 6),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Next',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
