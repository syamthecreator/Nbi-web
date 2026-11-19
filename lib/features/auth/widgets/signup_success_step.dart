import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../shared/models/user_role.dart';
import '../providers/auth_provider.dart';
import 'signup_input_fields.dart';

class SignupSuccessStep extends StatelessWidget {
  const SignupSuccessStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.redirectCountdown == 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final target = authProvider.selectedRole == UserRole.institution
                ? AppRoutes.createWorkspace
                : AppRoutes.selectInstitution;
            Navigator.pushReplacementNamed(context, target);
          });
        }

        return Column(
          children: [
            // Animated Success Celebration Badge (.success-icon-badge)
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x5910B981),
                        blurRadius: 24,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_rounded,
                      size: 52,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Positioned(
                  top: -10,
                  left: -10,
                  child: Text('✨', style: TextStyle(fontSize: 20)),
                ),
                const Positioned(
                  top: -12,
                  right: -12,
                  child: Text('🎉', style: TextStyle(fontSize: 20)),
                ),
                const Positioned(
                  bottom: -8,
                  right: 10,
                  child: Text('⭐', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Success Header (.success-title & .success-subtitle)
            Text(
              'Account Verified!',
              style: GoogleFonts.montserrat(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111111),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome to Notice Board India. Your account has been verified successfully.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF666666),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 24),

            // Verified Account Summary Card (.success-card)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0E6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFE5D6), width: 1.0),
              ),
              child: Column(
                children: [
                  _SummaryRow(
                    label: 'Full Name:',
                    value: authProvider.currentUser.fullName,
                  ),
                  const SizedBox(height: 12),
                  _SummaryRow(
                    label: 'Email:',
                    value: authProvider.currentUser.email,
                  ),
                  const SizedBox(height: 12),
                  _SummaryRow(
                    label: 'Phone:',
                    value: '+91 ${authProvider.currentUser.phone}',
                  ),
                  const SizedBox(height: 12),
                  const _SummaryRow(
                    label: 'Account Status:',
                    value: '🟢 Active Member',
                    isStatusBadge: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Primary Action Button (.btn-primary)
            SignupPrimaryButton(
              text: authProvider.selectedRole == UserRole.institution
                  ? 'Continue to Create Workspace'
                  : 'Continue to Select Institution',
              onPressed: () {
                final target = authProvider.selectedRole == UserRole.institution
                    ? AppRoutes.createWorkspace
                    : AppRoutes.selectInstitution;
                Navigator.pushReplacementNamed(context, target);
              },
            ),
            const SizedBox(height: 18),

            // Auto Redirect Timer Bar (.redirect-info-row & .redirect-progress-track)
            Column(
              children: [
                Text(
                  'Redirecting to Dashboard in ${authProvider.redirectCountdown}s...',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF777777),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAEAEA),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: ((5 - authProvider.redirectCountdown) / 5.0)
                        .clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6000), Color(0xFFFF4500)],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isStatusBadge;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isStatusBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF666666),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        isStatusBadge
            ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F9EE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF15803D),
                  ),
                ),
              )
            : Text(
                value,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: const Color(0xFF111111),
                ),
              ),
      ],
    );
  }
}
