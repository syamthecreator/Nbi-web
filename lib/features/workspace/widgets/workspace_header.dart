import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/app_logo.dart';

/// Workspace creation top header & illustration.
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
              const AppLogo(width: 58),
              const SizedBox(height: 18),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Create ',
                      style: AppTypography.heading1(
                        fontSize: isDesktop ? 38 : 28,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    TextSpan(
                      text: 'Workspace',
                      style: AppTypography.heading1(
                        fontSize: isDesktop ? 38 : 28,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Complete Your Institution Details To Create Your Secure Workspace.',
                style: AppTypography.subtitle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        if (isDesktop) ...[
          const SizedBox(width: 32),
          Image.asset(
            AppAssets.workspaceTeamIllustration,
            width: 340,
            height: 190,
            fit: BoxFit.contain,
          ),
        ],
      ],
    );
  }
}
