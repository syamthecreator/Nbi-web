import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Role screen copyright and legal links footer matching select-role.css .page-footer
class RoleFooterLinks extends StatelessWidget {
  const RoleFooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 14,
      runSpacing: 6,
      children: [
        Text(
          '© 2024 NBI. All rights reserved.',
          style: GoogleFonts.inter(
            fontSize: 13.1, // 0.82rem
            fontWeight: FontWeight.w400,
            color: const Color(0xFF777777),
          ),
        ),
        _FooterLink(text: 'Privacy Policy', onTap: () {}),
        _FooterLink(text: 'Terms of Service', onTap: () {}),
        _FooterLink(text: 'Contact Support', onTap: () {}),
        _FooterLink(text: 'Legal', onTap: () {}),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLink({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13.1,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF555555),
          ),
        ),
      ),
    );
  }
}
