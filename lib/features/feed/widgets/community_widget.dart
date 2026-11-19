import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/feed_provider.dart';

class CommunityWidget extends StatelessWidget {
  const CommunityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final feedProvider = context.read<FeedProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 18,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Join NBI Community',
            style: AppTypography.heading3(
              fontSize: 16.8,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Stay connected with live school notifications & exam updates.',
            style: TextStyle(
              fontSize: 12.8,
              color: Color(0xFF6B7280),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // WhatsApp Channel
          _SocialPillBtn(
            emoji: '💬',
            name: 'WhatsApp Channel',
            badge: '50k+ Members',
            actionText: 'Join',
            onTap: () => feedProvider.showToast('🚀 Joining WhatsApp Channel...'),
          ),
          const SizedBox(height: 10),

          // Telegram Updates
          _SocialPillBtn(
            emoji: '✈️',
            name: 'Telegram Updates',
            badge: 'Instant Alerts',
            actionText: 'Join',
            onTap: () => feedProvider.showToast('🚀 Opening Telegram Channel...'),
          ),
          const SizedBox(height: 10),

          // Instagram
          _SocialPillBtn(
            emoji: '📸',
            name: 'Instagram',
            badge: '@NoticeBoardIndia',
            actionText: 'Follow',
            onTap: () => feedProvider.showToast('📸 Visiting Instagram Page...'),
          ),
        ],
      ),
    );
  }
}

class _SocialPillBtn extends StatefulWidget {
  final String emoji;
  final String name;
  final String badge;
  final String actionText;
  final VoidCallback onTap;

  const _SocialPillBtn({
    required this.emoji,
    required this.name,
    required this.badge,
    required this.actionText,
    required this.onTap,
  });

  @override
  State<_SocialPillBtn> createState() => _SocialPillBtnState();
}

class _SocialPillBtnState extends State<_SocialPillBtn> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
              ? Matrix4.translationValues(0, -1, 0)
              : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white : const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered ? const Color(0xFFFFB380) : const Color(0xFFF3F4F6),
              width: 1,
            ),
            boxShadow: _isHovered
                ? const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 14,
                      offset: Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Text(
                widget.emoji,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 13.8,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      widget.badge,
                      style: const TextStyle(
                        fontSize: 11.8,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? AppColors.primaryOrange
                      : const Color(0xFFFFF0E6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.actionText,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: _isHovered ? Colors.white : AppColors.primaryOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
