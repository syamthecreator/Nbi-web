import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/background_shapes.dart';
import '../../../core/widgets/custom_button.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/role_provider.dart';
import '../widgets/role_card.dart';
import '../widgets/role_footer_links.dart';

/// Choose Your Role Screen - 1:1 match with select-role.html and select-role.css.
/// Pure Stateless architecture with Provider. Zero setState().
class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 860;

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Stack(
        children: [
          // Background Shapes: Top-Right (Splash-1 flipped) and Bottom-Left (Splash-2 flipped)
          const BackgroundShapes(showTopRight: true, showBottomLeft: true),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1040),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Top Header Branding (.role-header)
                      const Center(child: AppLogo(width: 72)),
                      const SizedBox(height: 8),

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Welcome To ',
                              style: AppTypography.heading1(
                                fontSize: 37.6, // 2.35rem
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF000000),
                              ).copyWith(letterSpacing: -0.5, height: 1.1),
                            ),
                            TextSpan(
                              text: 'NBI',
                              style: AppTypography.heading1(
                                fontSize: 37.6,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryOrange,
                              ).copyWith(letterSpacing: -0.5, height: 1.1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),

                      Text(
                        '“Stay Connected. Stay Informed.”',
                        style: GoogleFonts.inter(
                          fontSize: 15.2, // 0.95rem
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF555555),
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      // Main Role Selection Card Container (.role-card-container)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(44, 30, 44, 32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: const Color(0xFFFFE4D6),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF5A00)
                                  .withValues(alpha: 0.04),
                              blurRadius: 36,
                              offset: const Offset(0, 14),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Choose Your Role',
                              style: AppTypography.heading2(
                                fontSize: 25.6, // 1.6rem
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF111111),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 480),
                              child: Text(
                                'Your role helps us personalize your experience and show you what matters most.',
                                style: GoogleFonts.inter(
                                  fontSize: 14.1, // 0.88rem
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF666666),
                                  height: 1.45,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // 3 Interactive Role Selection Cards Grid (.role-grid)
                            Consumer2<RoleProvider, AuthProvider>(
                              builder:
                                  (context, roleProvider, authProvider, _) {
                                    final selected = roleProvider.selectedRole;
                                    final roles = roleProvider.availableRoles;

                                    if (isDesktop) {
                                      return IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            for (
                                              int i = 0;
                                              i < roles.length;
                                              i++
                                            ) ...[
                                              if (i > 0)
                                                const SizedBox(width: 22),
                                              Expanded(
                                                child: RoleCard(
                                                  model: roles[i],
                                                  isSelected:
                                                      selected == roles[i].role,
                                                  onTap: () {
                                                    roleProvider.selectRole(
                                                      roles[i].role,
                                                    );
                                                    authProvider.selectRole(
                                                      roles[i].role,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          for (
                                            int i = 0;
                                            i < roles.length;
                                            i++
                                          ) ...[
                                            if (i > 0)
                                              const SizedBox(height: 18),
                                            RoleCard(
                                              model: roles[i],
                                              isSelected:
                                                  selected == roles[i].role,
                                              onTap: () {
                                                roleProvider.selectRole(
                                                  roles[i].role,
                                                );
                                                authProvider.selectRole(
                                                  roles[i].role,
                                                );
                                              },
                                            ),
                                          ],
                                        ],
                                      );
                                    }
                                  },
                            ),

                            const SizedBox(height: 26),

                            // Continue Button (Pill shape 210px x 46px, with Saving... feedback)
                            Consumer2<RoleProvider, AuthProvider>(
                              builder:
                                  (context, roleProvider, authProvider, _) {
                                    final isSaving = roleProvider.isSaving;

                                    return CustomButton(
                                      text: isSaving ? 'Saving...' : 'Continue',
                                      width: 210,
                                      height: 46,
                                      borderRadius: BorderRadius.circular(23),
                                      trailingIcon: isSaving
                                          ? null
                                          : const Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                      onPressed: isSaving
                                          ? null
                                          : () {
                                              roleProvider.submitRole(() {
                                                if (context.mounted) {
                                                  Navigator.pushNamed(
                                                    context,
                                                    AppRoutes.signup,
                                                  );
                                                }
                                              });
                                            },
                                    );
                                  },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Footer Legal & Copyright Links (.page-footer)
                      const RoleFooterLinks(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
