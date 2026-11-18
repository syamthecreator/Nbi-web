import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../providers/auth_provider.dart';
import 'signup_input_fields.dart';

/// Step 1: Initial Form State with inputs and terms agreement.
/// 1:1 match with source_nbi signup.html & signup.css (#step1)
class SignupFormStep extends StatelessWidget {
  const SignupFormStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full Name Input Group (.form-group margin-bottom: 22px)
            SignupTextField(
              label: 'Full Name *',
              hintText: 'Rahul Sharma',
              controller: authProvider.nameController,
              icon: Icons.person_outline,
              onChanged: authProvider.updateFullName,
            ),
            const SizedBox(height: 22),

            // Email Input Group (.form-group margin-bottom: 22px)
            SignupTextField(
              label: 'Email *',
              hintText: 'email@gmail.com',
              controller: authProvider.emailController,
              keyboardType: TextInputType.emailAddress,
              icon: Icons.mail_outline,
              onChanged: authProvider.updateEmail,
            ),
            const SizedBox(height: 22),

            // Contact / Phone Input Group (.form-group margin-bottom: 22px)
            SignupPhoneField(
              label: 'Contact / Phone *',
              controller: authProvider.phoneController,
              onChanged: authProvider.updatePhone,
            ),
            const SizedBox(height: 20),

            // Terms Checkbox (.checkbox-container)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Checkbox(
                    value: authProvider.termsAccepted,
                    activeColor: AppColors.primaryOrange,
                    side: const BorderSide(
                      color: Color(0xFFFF8C42),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onChanged: authProvider.toggleTerms,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'I agree to the ',
                      style: GoogleFonts.inter(
                        fontSize: 14.4,
                        color: const Color(0xFF555555),
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          style: GoogleFonts.inter(
                            fontSize: 14.4,
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const TextSpan(text: ' & '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: GoogleFonts.inter(
                            fontSize: 14.4,
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Primary Submit Button (.btn-primary)
            SignupPrimaryButton(
              text: 'Send OTP',
              isLoading: authProvider.isLoading,
              onPressed: authProvider.sendOtp,
            ),
          ],
        );
      },
    );
  }
}
