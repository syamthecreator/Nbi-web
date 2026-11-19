import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/background_shapes.dart';
import '../models/auth_state_model.dart';
import '../providers/auth_provider.dart';
import '../widgets/otp_verification_step.dart';
import '../widgets/signup_form_step.dart';
import '../widgets/signup_hero_section.dart';
import '../widgets/signup_success_step.dart';

/// Sign Up Screen - Refactored production architecture using Provider.
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 960;

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Stack(
        children: [
          // Background Shape on Top Right
          const BackgroundShapes(showTopRight: true),

          isDesktop
              ? Row(
                  children: [
                    // Left 50vw Hero Branding Section
                    const Expanded(child: SignupDesktopHero()),

                    // Right 50vw Form Section
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 40,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: const _SignupFormContainer(),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SignupMobileHero(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 32,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: const _SignupFormContainer(),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class _SignupFormContainer extends StatelessWidget {
  const _SignupFormContainer();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final step = authProvider.currentStep;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (step != SignupStep.success) ...[
              // Header (.form-header)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sign ',
                      style: AppTypography.heading1(
                        fontSize: 46.0,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF000000),
                      ).copyWith(letterSpacing: -0.5, height: 1.1),
                    ),
                    TextSpan(
                      text: 'Up',
                      style: AppTypography.heading1(
                        fontSize: 46.0,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryOrange,
                      ).copyWith(letterSpacing: -0.5, height: 1.1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              Text(
                'Join The NBI Community',
                style: GoogleFonts.inter(
                  fontSize: 16.8,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF555555),
                ),
              ),
              const SizedBox(height: 28),
            ],

            // Active Form Step
            if (step == SignupStep.form) const SignupFormStep(),
            if (step == SignupStep.otp) const OtpVerificationStep(),
            if (step == SignupStep.success) const SignupSuccessStep(),

            // Error Display Banner
            if (authProvider.errorMessage != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.urgentBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.urgentText.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 18,
                      color: AppColors.urgentText,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        authProvider.errorMessage!,
                        style: AppTypography.bodySmall(
                          color: AppColors.urgentText,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Divider: Welcome (.form-divider)
            if (step != SignupStep.success) ...[
              const SizedBox(height: 32),
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: Color(0xFFEEEEEE), thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'Welcome',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF888888),
                        fontSize: 14.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: Color(0xFFEEEEEE), thickness: 1),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
