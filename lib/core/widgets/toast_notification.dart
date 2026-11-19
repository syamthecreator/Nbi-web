import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToastNotification extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;

  const ToastNotification({super.key, required this.message, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 30,
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(14),
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6000), Color(0xFFFF4500)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Color(0x59FF5A00),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  message,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (onDismiss != null) ...[
                const SizedBox(width: 12),
                InkWell(
                  onTap: onDismiss,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
