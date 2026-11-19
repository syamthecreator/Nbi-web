import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../class_division/providers/class_division_provider.dart';
import '../providers/institution_provider.dart';

/// Sticky bottom action bar
class InstitutionBottomBar extends StatelessWidget {
  final InstitutionProvider instProvider;

  const InstitutionBottomBar({super.key, required this.instProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEAEAEA), width: 1.0)),
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
              // Selection Status Text
              Text(
                '${instProvider.selectedCount} institution${instProvider.selectedCount > 1 ? 's' : ''} followed',
                style: GoogleFonts.montserrat(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryOrange,
                ),
              ),

              // Continue Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: () {
                    final cdProvider = context.read<ClassDivisionProvider>();
                    cdProvider.syncWithFollowedInstitutions(
                      instProvider.followedInstitutions
                          .map((i) => i.name)
                          .toList(),
                    );
                    Navigator.pushNamed(context, AppRoutes.selectClassDivision);
                  },
                  child: Ink(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6000), Color(0xFFFF4500)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF5A00)
                              .withValues(alpha: 0.28),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Continue',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
