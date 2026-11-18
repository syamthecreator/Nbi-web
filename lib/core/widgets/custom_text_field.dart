import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool isRequired;
  final int? maxLength;
  final bool readOnly;
  final Color? borderColor;
  final Color? asteriskColor;
  final double borderRadius;
  final double height;
  final TextStyle? labelStyle;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.isRequired = false,
    this.maxLength,
    this.readOnly = false,
    this.borderColor,
    this.asteriskColor,
    this.borderRadius = 10.0,
    this.height = 48.0,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? const Color(0xFFCBD5E1);
    final effectiveAsteriskColor = asteriskColor ?? const Color(0xFFEF4444);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: labelStyle ??
                  GoogleFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  color: effectiveAsteriskColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: height,
          child: TextFormField(
            initialValue: controller == null ? initialValue : null,
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            maxLength: maxLength,
            readOnly: readOnly,
            cursorColor: AppColors.primaryOrange,
            style: GoogleFonts.inter(
              fontSize: 14.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F172A),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF94A3B8),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              counterText: '',
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: effectiveBorderColor, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: effectiveBorderColor, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: AppColors.primaryOrange, width: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

