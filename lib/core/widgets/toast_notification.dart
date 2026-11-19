import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToastNotification extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;

  const ToastNotification({super.key, required this.message, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      right: 24,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(10),
            border: const Border(
              left: BorderSide(color: Color(0xFFFF5A00), width: 4),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 30,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (onDismiss != null) ...[
                const SizedBox(width: 12),
                InkWell(
                  onTap: onDismiss,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white70,
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
