import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

/// Form input with peach/orange border and left icon matching signup.css .form-input & .input-icon
class SignupTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final IconData icon;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const SignupTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.initialValue,
    this.controller,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.8,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111111),
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          child: Builder(
            builder: (context) {
              final hasFocus = Focus.of(context).hasFocus;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: hasFocus ? AppColors.primaryOrange : const Color(0xFFFF8C42),
                    width: 1.5,
                  ),
                  boxShadow: hasFocus
                      ? const [
                          BoxShadow(
                            color: Color(0x24FF5A00),
                            spreadRadius: 4,
                            blurRadius: 0,
                          ),
                        ]
                      : null,
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // Icon at left: 18px matching signup.css .input-icon
                    Positioned(
                      left: 18,
                      child: Icon(
                        icon,
                        color: AppColors.primaryOrange,
                        size: 20,
                      ),
                    ),

                    // Input with padding-left: 50px matching signup.css .form-input
                    TextFormField(
                      initialValue: controller == null ? initialValue : null,
                      controller: controller,
                      keyboardType: keyboardType,
                      onChanged: onChanged,
                      cursorColor: AppColors.primaryOrange,
                      cursorHeight: 22,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF111111),
                      ),
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF999999),
                        ),
                        contentPadding: const EdgeInsets.only(left: 50, right: 18),
                        fillColor: Colors.transparent,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Phone input with country flag, +91 prefix and padding-left: 84px matching signup.css .phone-input & .country-prefix
class SignupPhoneField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const SignupPhoneField({
    super.key,
    required this.label,
    this.initialValue,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.8,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111111),
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          child: Builder(
            builder: (context) {
              final hasFocus = Focus.of(context).hasFocus;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: hasFocus ? AppColors.primaryOrange : const Color(0xFFFF8C42),
                    width: 1.5,
                  ),
                  boxShadow: hasFocus
                      ? const [
                          BoxShadow(
                            color: Color(0x24FF5A00),
                            spreadRadius: 4,
                            blurRadius: 0,
                          ),
                        ]
                      : null,
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // Prefix: 🇮🇳 +91 at left: 16px matching signup.css .country-prefix
                    Positioned(
                      left: 16,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('🇮🇳', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 4),
                          Text(
                            '+91',
                            style: GoogleFonts.inter(
                              fontSize: 15.2,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Phone digits with padding-left: 84px matching signup.css .phone-input
                    TextFormField(
                      initialValue: controller == null ? initialValue : null,
                      controller: controller,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onChanged: onChanged,
                      cursorColor: AppColors.primaryOrange,
                      cursorHeight: 22,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF111111),
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: '8787878888',
                        hintStyle: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF999999),
                        ),
                        contentPadding: const EdgeInsets.only(left: 84, right: 18),
                        fillColor: Colors.transparent,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Full width primary gradient action button with loading spinner matching signup.css .btn-primary
class SignupPrimaryButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final IconData? icon;
  final VoidCallback onPressed;

  const SignupPrimaryButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6000), Color(0xFFFF4500)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x47FF5A00),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: isLoading ? null : onPressed,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.montserrat(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(icon ?? Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
