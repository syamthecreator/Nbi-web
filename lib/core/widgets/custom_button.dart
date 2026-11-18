import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? trailingIcon;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color textColor;
  final double height;
  final double? width;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.trailingIcon,
    this.gradient,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.height = 46,
    this.width = 210,
    this.borderRadius,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(23);
    final effectiveGradient = gradient ??
        (backgroundColor == null
            ? const LinearGradient(
                colors: [Color(0xFFFF6000), Color(0xFFFF4500)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: effectiveGradient == null ? (backgroundColor ?? AppColors.primaryOrange) : null,
        gradient: effectiveGradient,
        borderRadius: effectiveRadius,
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: const Color(0xFFFF5A00).withValues(alpha: 0.28),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: effectiveRadius,
          onTap: isLoading ? null : onPressed,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: AppTypography.buttonText(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (trailingIcon != null) ...[
                        const SizedBox(width: 8),
                        trailingIcon!,
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
