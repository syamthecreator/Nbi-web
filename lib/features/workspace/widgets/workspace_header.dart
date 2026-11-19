import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_logo.dart';

/// Workspace creation top header & illustration
class WorkspaceHeader extends StatelessWidget {
  final bool isDesktop;

  const WorkspaceHeader({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(width: 88),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Create ',
                      style: GoogleFonts.montserrat(
                        fontSize: isDesktop ? 44 : 30,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF0F172A),
                        letterSpacing: -0.8,
                        height: 1.15,
                      ),
                    ),
                    TextSpan(
                      text: 'Workspace',
                      style: GoogleFonts.montserrat(
                        fontSize: isDesktop ? 44 : 30,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryOrange,
                        letterSpacing: -0.8,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Complete Your Institution Details To Create Your Secure Workspace.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        if (isDesktop) ...[
          const SizedBox(width: 40),
          Transform.translate(
            offset: const Offset(0, -10),
            child: Image.asset(
              AppAssets.workspaceTeamIllustration,
              width: 440,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ],
    );
  }
}
