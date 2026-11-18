import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/auth_provider.dart';
import 'signup_input_fields.dart';

/// Step 2: OTP Verification step with 4-digit input grid, resend timer, and change details.
/// 1:1 match with source_nbi signup.html & signup.css (#step2)
class OtpVerificationStep extends StatelessWidget {
  const OtpVerificationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Target recipient notification (.otp-header .otp-sent-info)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Enter 4-digit OTP sent to ',
                    style: GoogleFonts.inter(
                      fontSize: 15.6,
                      color: const Color(0xFF444444),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '+91 ${authProvider.phone}',
                    style: AppTypography.heading3(
                      fontSize: 15.6,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111111),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4 Full-Width OTP Boxes - ALL 4 boxes have the EXACT same width!
            Row(
              children: [
                for (int i = 0; i < 4; i++) ...[
                  if (i > 0) const SizedBox(width: 16),
                  Expanded(
                    child: _OtpDigitBox(
                      index: i,
                      controller: authProvider.otpControllers[i],
                      focusNode: authProvider.otpFocusNodes[i],
                      onChanged: (val) => authProvider.handleOtpInput(i, val),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),

            // Resend Timer Row (.otp-timer-row)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Didn't receive OTP?",
                  style: GoogleFonts.inter(
                    fontSize: 14.4,
                    color: const Color(0xFF666666),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                authProvider.canResendOtp
                    ? InkWell(
                        onTap: authProvider.resendOtp,
                        child: Text(
                          'Resend OTP',
                          style: GoogleFonts.inter(
                            fontSize: 14.4,
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : Text(
                        'Resend OTP (${authProvider.resendCountdown}s)',
                        style: GoogleFonts.inter(
                          fontSize: 14.4,
                          color: const Color(0xFFA0A0A0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 24),

            // Verify & Create Account Button (.btn-primary)
            SignupPrimaryButton(
              text: 'Verify & Create Account',
              isLoading: authProvider.isLoading,
              icon: Icons.check_circle_outline,
              onPressed: authProvider.verifyOtp,
            ),
            const SizedBox(height: 18),

            // Wrong phone / email? Change details link (.otp-change-details)
            Center(
              child: InkWell(
                onTap: authProvider.goToStep1,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Wrong email or phone number? ',
                          style: GoogleFonts.inter(
                            fontSize: 14.4,
                            color: const Color(0xFF555555),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Change Details',
                          style: GoogleFonts.inter(
                            fontSize: 14.4,
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Single OTP input box with reactive focus border & outer glow matching signup.css .otp-digit:focus
class _OtpDigitBox extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const _OtpDigitBox({
    required this.index,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: focusNode,
      builder: (context, _) {
        final hasFocus = focusNode.hasFocus;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: hasFocus ? AppColors.primaryOrange : const Color(0xFFFF8C42),
              width: 2.0,
            ),
            boxShadow: hasFocus
                ? const [
                    BoxShadow(
                      color: Color(0x29FF5A00),
                      spreadRadius: 4,
                      blurRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              cursorColor: AppColors.primaryOrange,
              cursorHeight: 26,
              style: AppTypography.heading1(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111111),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              decoration: const InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.zero,
                fillColor: Colors.transparent,
                filled: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
        );
      },
    );
  }
}
