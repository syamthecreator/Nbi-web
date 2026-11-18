import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String placeholder;
  final String? selectedValue;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final bool isRequired;
  final double height;
  final double borderRadius;
  final Color? borderColor;
  final Color? asteriskColor;
  final TextStyle? labelStyle;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
    this.isRequired = false,
    this.height = 48.0,
    this.borderRadius = 10.0,
    this.borderColor,
    this.asteriskColor,
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
          child: DropdownButtonFormField<String>(
            initialValue: selectedValue?.isNotEmpty == true ? selectedValue : null,
            hint: Text(
              placeholder,
              style: GoogleFonts.inter(
                color: const Color(0xFF94A3B8),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B), size: 20),
            decoration: InputDecoration(
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
            items: options.map((opt) {
              final isSelected = opt == selectedValue;
              return DropdownMenuItem<String>(
                value: opt,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      opt,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? AppColors.primaryOrange : const Color(0xFF0F172A),
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check, size: 16, color: AppColors.primaryOrange),
                  ],
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) onChanged(val);
            },
          ),
        ),
      ],
    );
  }
}

